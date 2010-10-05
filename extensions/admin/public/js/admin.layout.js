;(function ($) {
  var $nav  = $("#nav"),
      $area = $("#area"),
      $top  = $("#top"),
      $context = $nav.add($area);

  function onResize() {
    $context.each(function () {
      var height = $(window).height() - $top.outerHeight();
      height -= parseInt($(this).css('padding-top'));
      height -= parseInt($(this).css('padding-bottom'));
      $(this).height(height);
    });
    $area.width($(window).width() - $nav.outerWidth());
  }

  $(window).resize(onResize);
  $(function () {
    $(document.body).fadeIn('fast');
    onResize();
  });
})(jQuery);
