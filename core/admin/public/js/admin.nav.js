;(function ($) {
  var $area = $("#area");
  var $content = $("#content");
  var $nav  = $("#nav");
  var $body = $("body");
  var $title = $("#title");

  var link = null;

  var speed = 250;

  // Back button
  $("#nav nav.back a")
    .live('mousedown', function (e) {
      $(this).closest('nav.back').addClass('mousedown');
    })

    .live('mouseup', function (e) {
      window.setTimeout(function () {
        $(this).closest('nav.back').removeClass('mousedown');
      }, 100);
    });

  // Redudndant submit
  $("a[href=#submit]").live('click', function (e) {
    $("form").submit();
    return false;
  });

  // Highlight
  $("#nav > div a").live('click', function (e) {
    $nav.find('.active').removeClass('active');
    $(this).addClass('active');
  });

  // The click!
  $("a").live('click', function (e) {
    var href = $(this).attr('href');

    // Don't do this on anything that's supposed to do it's thang.
    if ($(this).is('.ext')) { return; }
    if ($(this).attr('rel') == 'ext') { return; }
    if ($(this).attr('target')) { return; }
    if (href.match(/^javascript:/)) { return; }
    if (href.match(/^#/)) { return; }

    e.preventDefault();

    link = $(this);
    if (window.location.hash == '#!'+href) { return; }

    window.location.hash = "#!" + href;
  });

  function htmlCallback (html) {
    var $data = $("<div>").html(html);
    $body.show();

    if ($data.find("#redirect").length) {
      url = $data.find("#redirect").html();
      window.location = url;
      return false;
    }

    // Make sure it's not some garbage URL/HTML we're being fed.
    if (!$data.find("#area").length) {
      alert("Oh no. What did you do?");
      $.unscreen();
      return false;
    }

    // Determite the animation that will happen.
    var anim = 'html';
    if (link) {
      if (link.parents('#nav .browse').length) { anim = 'browse'; }
      else if (link.parents('#nav .back').length) { anim = 'back'; }
    }

    // Bring the content in.
    $("#nav").htmlInto($data.find("#nav").html(), anim);

    function onTransitionFinish() {
      $.unscreen();
      $("#tabs").html($data.find("#tabs").html());
      $("#title").html($data.find("#title").html());
      $area.attr('class', $data.find("#area").attr('class'));
      $area.html($data.find("#area").html());

      if ($.sidebar) {
        if ($("#area").is('.no-sidebar')) { $.sidebar.hide(); }
        else { $.sidebar.show(); }
      }
    };

    // the 'done doing the sidebar' callback.
    var duration = speed * 2;
    if (anim == 'html') { duration = 0; }
    window.setTimeout(onTransitionFinish, duration);

    // Change the page <title>
    var title = html.match(/<title>(.*?)<\/title>/);
    if (title) { $("title").html(title[1]); }

    $(window).trigger('resize');
    focusFirstField();
  }

  var enableBackToStart = false;

  // Went back to the start
  $.hashListen('', function () {
    // We need to catch this because, otherwise, the first page load
    // will try to (re)load the start page.
    if (!enableBackToStart) { return; }
    $area.screen(); $body.screen();
    $.get(window.location, htmlCallback);
  });

  $.hashListen('!(.*)', function (href) {
    enableBackToStart = true;
    $area.screen(); $body.screen();
    $.get(href, htmlCallback);
  });

  $("form").live('submit', function (e) {
    var $this = $(this);
    $area.screen();

    // Those that are 'ext' shouldn't do things in place.
    if ($this.is('.ext')) { return; }

    $.post($this.attr('action'), $this.serialize(), htmlCallback);
    e.preventDefault();
    return false;
  });

  $("body").ajaxError(function () {
    alert("Sorry, something went wrong :(");
    $body.show();
    $.unscreen();
  });

  $(function () {
    if (window.location.hash.substr(0,2) == '#!') {
      $body.hide();
    }
  });

  // * * * *
  //
  $.fn.htmlInto = function(html, what) {
    if (what == 'browse')
      { return this.navInto(html); }
    else if (what == 'back')
      { return this.backInto(html); }
    else
      { return this.html(html); }
  };

  $.fn.fixpos = function() {
    var list = [];
    this.each(function () {
      var $this = $(this);
      var pos = $this.position();
      list.push([$this, { position: 'absolute', top: pos.top, left: pos.left, width: $this.width(), height: $this.height() }]);
    });

    for (var i in list) {
      var tuple = list[i];
      tuple[0].css(tuple[1]);
    }
  };

  $.fn.navInto = function(html) {
    var $this = $(this);
    var hadBack = $this.find("nav.back > *").length > 0;

    $this.addClass('transitioning');

    // Animate the (just-clicked) button.
    var $active = $this.find('a.active');
    //$active.add($sel).fixpos();
    $this.find('li, h3').fixpos();

    // Animate a duplicate
    var $clone = $active.parent('li').clone();
    $active.parent('li').parent().append($clone);

    $active.removeClass('active');
    $clone.animate({
      top: 0
    }, speed);
    $clone.find('a').animate({
      paddingRight: 30, paddingLeft: 10, backgroundPosition: '110% center'
    }, speed);

    $this.find('nav.back').slideUp(speed);

    // Everything else
    var $sel = $this.find('nav:not(.back) a:not(.active), h3');

    //$sel.fixpos();
    $sel.animate({ opacity: 0, top: '-=5' }, speed, function () {
      $this.html(html);
      var $sel = $this.find('nav:not(.back) a:not(.active), nav:not(.back) h3');
      $this.find('nav.back').hide().slideDown(speed);

      $sel
        .css({ opacity: 0, position: 'relative', left: 0 })
        .animate({ opacity: 1, left: 0 }, speed, function () {
          $this.removeClass('transitioning');
        });
    });
  };

  $.fn.backInto = function(html) {
    var $this = $(this);
    $this.addClass('transitioning');

    // Animate the (just-clicked) back button.
    $this.find('nav.back a').animate({
      'padding-top': 4, 'padding-bottom': 4, 'padding-left': 10, 'background-position': '-30px center'
    }, speed);

    // Hide everything else, then show them all back.
    $this.find('nav:not(.back)')
    .css({ opacity: 1, position: 'relative', left: 0 })
    .animate({ opacity: 0, left: 0 }, speed, function () {
      $this.html(html);
      var $selSlide = $this.find('nav.back');
      var $selFade  = $this.find('nav:not(.back) a:not(.active), nav:not(.back) h3');
      $selSlide.hide().slideDown(speed, function () {
        $this.removeClass('transitioning');
      });
      $selFade
        .css({ opacity: 0, position: 'relative', left: 0 })
        .animate({ opacity: 1, left: 0 }, speed);
    });
  };

  function focusFirstField() {
    var field = $("#area").find("input, textarea, select").filter(":visible").get(0);
    if (!field) { return; }
    field.focus();
    if (field.selectionStart != undefined) {
      var val = field.value.length;
      field.selectionStart = val;
      field.selectionEnd   = val;
    }
  }

  $(focusFirstField);
})(jQuery);
