;(function ($) {
  var back = false;

  $("#nav a.back").live('click', function (e) {
    e.preventDefault();
    back = true;
    history.go(-1);
  });

  $("#nav > div a").live('click', function (e) {
    e.preventDefault();

    var href = $(this).attr('href');
    window.location.hash = "#!" + href;
  });

  $.hashListen('!(.*)', function (href) {
    $.get(href, function (html) {
      var $context = $("<div>").html(html);
      $("#nav > div").transitionInto($context.find("#nav > div").html(), back);
      $("#area").html($context.find("#area").html());
      back = false;
    });
  });

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
