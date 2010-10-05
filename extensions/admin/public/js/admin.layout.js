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
    $area.width($(window).width() - $nav.outerWidth());
  }

  $(window).resize(onResize);
  $(function () {
    $(document.body).show();
    onResize();
  });
})(jQuery);
