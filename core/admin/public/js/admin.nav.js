;(function ($) {
  var $area = $("#area");
  var $nav  = $("#nav");

  $("#nav > div a, #toolbar a, #top h3 a").live('click', function (e) {
    e.preventDefault();

    var href = $(this).attr('href');

    $area.css({ opacity: 0.85 });

    window.location.hash = "#!" + href;
  });

  $.hashListen('!(.*)', function (href) {
    $.get(href, function (html) {
      var $data = $("<div>").html(html);

      $("#context").html($data.find("#context").html());
      $("#area")
        .animate({ opacity: 1 }, 150)
        .html($data.find("#area").html());

      var title = html.match(/<title>(.*?)<\/title>/);
      if (title) { $("title").html(title[1]); }
    });
  });

  // * * * *

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
