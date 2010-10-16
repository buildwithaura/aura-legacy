;(function ($) {
  $.uiscreen.background = "";
  $.uiscreen.opacity = 0.8;
  $.uiscreen.fadeout_time = 0;

  $("textarea, input, select")
    .live('focus', function () {
      $(this).closest('form p').addClass('focus');
    })
    .live('blur', function () {
      $(this).closest('form p').removeClass('focus');
    });

  $(function () { $("body").show(); });
})(jQuery);
