;(function ($) {
  var $area = $("#area");
  var $nav  = $("#nav");
  var $body = $("body");

  var link = null;

  // Highlight
  $("#nav > div a").live('click', function (e) {
    $nav.find('.active').removeClass('active');
    $(this).addClass('active');
  });

  $("#nav > div a, #toolbar a, #top h3 a").live('click', function (e) {
    if ($(this).is('.ext')) { return; }

    e.preventDefault();

    var href = $(this).attr('href');
    link = $(this);

    $area.css({ opacity: 0.6 });

    window.location.hash = "#!" + href;
  });

  $.hashListen('!(.*)', function (href) {
    $.get(href, function (html) {
      var $data = $("<div>").html(html);

      $body.show();

      // Determite the animation that will happen.
      var anim = 'html';
      if (link) {
        if (link.parents('#nav .browse').length) { anim = 'browse'; }
        else if (link.parents('#nav .back').length) { anim = 'back'; }
      }

      $("#nav").htmlInto($data.find("#nav").html(), anim);

      $("#area")
        .css({ opacity: 1 })
        .html($data.find("#area").html());

      var title = html.match(/<title>(.*?)<\/title>/);
      if (title) { $("title").html(title[1]); }
    });
  });

  $("body").ajaxError(function () {
    alert("Sorry, something went wrong :(");
      $body.show();
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
    var speed = 350;
    var hadBack = $this.find("nav.back > *").length > 0;

    $this.addClass('transitioning');

    // Animate the (just-clicked) button.
    var $active = $this.find('a.active');
    //$active.add($sel).fixpos();
    $this.find('li, h3').fixpos();

    $active.animate({
      paddingRight: 30, paddingLeft: 10, backgroundPosition: '110% center'
    }, speed);
    $active.closest('li').animate({
      top: 0
    }, speed);

    $this.find('nav.back').slideUp(speed);

    // Everything else
    var $sel = $this.find('nav:not(.back) a:not(.active), h3');

    //$sel.fixpos();
    $sel.animate({ opacity: 0, left: '-=0' }, speed, function () {
      $this.html(html);
      var $sel = $this.find('nav:not(.back) a:not(.active), nav:not(.back) h3');
      $this.find('nav.back').hide().slideDown(speed);

      $sel
        .css({ opacity: 0, position: 'relative', left: -10 })
        .animate({ opacity: 1, left: 0 }, speed, function () {
          $this.removeClass('transitioning');
        });
    });
  };

  $.fn.backInto = function(html) {
    var $this = $(this);
    var speed = 350;
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
})(jQuery);
