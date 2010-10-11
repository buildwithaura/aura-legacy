;(function ($) {
  var $nav  = $("#nav"),
      $area = $("#area"),
      $body = $("body"),
      $context = $nav.add($area);

  var sidebarWidth = 200; //$nav.outerWidth();

  function onResize() {
    // Stretch heights.
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
    if (!$nav.is(':hidden')) { padding += $nav.outerWidth(); }
    $area.css({ width: $(window).width() - padding });
  }

  $(window).resize(onResize);
  $(function () {
    $(document.body).show();
    onResize();
  });

  $.sidebar = function () {
  };

  $.sidebar.hide = function () {
    $body.addClass('no-sidebar');
    $nav.hide();
    $area.css({ left: 0 });
    console.log(sidebarWidth);
    onResize();
  };

  $.sidebar.show = function () {
    console.log(sidebarWidth);
    $body.removeClass('no-sidebar');
    $nav.show();
    $area.css({ left: sidebarWidth });
    onResize();
  };
})(jQuery);
