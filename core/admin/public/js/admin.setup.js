;(function ($) {
  $.uiscreen.background = "";
  $.uiscreen.opacity = 0.8;
  $.uiscreen.fadeout_time = 0;

  // Focus
  $("textarea, input, select")
    .live('focus', function () {
      $(this).closest('form p').addClass('focus');
    })
    .live('blur', function () {
      $(this).closest('form p').removeClass('focus');
    });

  // Preload of sorts
  $(function () { $("body").show(); });

  // Wysiwyg
  $("textarea.html, p.html textarea").livequery(function () {
    $(this).wysiwyg({
      css: '/css/admin_wysiwyg_field.css'
    });
  });

  $("div.wysiwyg iframe").live('focus', function () {
  });
})(jQuery);
