;(function ($) {
  var $nav  = $("#nav"),
      $area = $("#area"),
      $body = $("body"),
      $title= $("#title"),
      $top  = $("#top"),
      $context = $nav.add($area);

  var sidebarWidth = 200; //$nav.outerWidth();

  $('body').addClass('fixed-layout');

  function onResize() {
    var height = $(window).height();
    height -= $top.outerHeight();

    // Stretch heights.
    $nav.height(height);
    $area.height(height - $title.outerHeight());

    $area.css({ top: $top.outerHeight() + $title.outerHeight() });

    // Widths of area and title
    var padding = 0;
    if (!$nav.is(':hidden')) { padding += $nav.outerWidth(); }
    $area.add($title)
      .css({ width: $(window).width() - padding, left: padding })
  }

  $(window).resize(onResize);
  $(function () {
    $(document.body).show();
    if ($('#area').is('.no-sidebar')) { $.sidebar.hide(); }
    onResize();
  });

  $.sidebar = function () {
  };

  $.sidebar.hide = function () {
    $body.addClass('no-sidebar');
    $nav.hide();
    $area.css({ left: 0 });
    onResize();
  };

  $.sidebar.show = function () {
    $body.removeClass('no-sidebar');
    $nav.show();
    $area.css({ left: sidebarWidth });
    onResize();
  };
})(jQuery);
