;(function ($) {
  var $nav  = $("#nav"),
      $area = $("#area"),
      $context = $nav.add($area);

  function onResize() {
    $context.each(function () {
      var height = $(window).height();
      height -= parseInt($(this).offset().top);
      height -= parseInt($(this).css('padding-top'));
      height -= parseInt($(this).css('padding-bottom'));
      $(this).height(height);
    });
    var padding = 0;
    padding += parseInt($area.css('padding-left'));
    padding += parseInt($area.css('padding-right'));
    $area.css({ width: $(window).width() - $nav.outerWidth() - padding });
  }

  $(window).resize(onResize);
  $(function () {
    $(document.body).show();
    onResize();
  });
})(jQuery);
