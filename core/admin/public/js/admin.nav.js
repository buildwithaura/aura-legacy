;(function ($) {
  var $area = $("#area");
  var $nav  = $("#nav");
  var $body = $("body");

  var link = null;

  $("#nav > div a, #toolbar a, #top h3 a").live('click', function (e) {
    if ($(this).is('.ext')) { return; }

    e.preventDefault();

    var href = $(this).attr('href');
    link = $(this);

    $area.css({ opacity: 0.85 });

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
        .animate({ opacity: 1 }, 150)
        .html($data.find("#area").html());

      var title = html.match(/<title>(.*?)<\/title>/);
      if (title) { $("title").html(title[1]); }
    });
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
      { return this.transitionInto(html); }
    else if (what == 'back')
      { return this.transitionInto(html, true); }
    else
      { return this.html(html); }
  };

  $.fn.transitionInto = function(html, backwards) {
    var $this = $(this);
    var speed = 150;
    var offset = 20;
    if (backwards == true) { offset *= -1; }

    $this.find("> *")
      .css({ position: 'relative' })
      .animate(
        { left: (offset*-1)+'px', opacity: 0 }, speed,
        function() {
          console.log(".");
          $this.html(html);
          $this.find("> *")
            .css({ position: 'relative', left: offset+'px', opacity: 0 })
            .animate({ left: 0, opacity: 1 }, speed);
        });
  };
})(jQuery);
