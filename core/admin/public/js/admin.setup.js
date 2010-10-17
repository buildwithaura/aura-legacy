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
      css: '/css/admin_wysiwyg_field.css',
      controls: {
        strikeThrough: { visible: false },
        subscript: { visible: false },
        superscript: { visible: false },
        separator03: { visible: false },
        undo: { visible: false },
        redo: { visible: false },
        separator04: { visible: false },
        cut: { visible: false },
        copy: { visible: false },
        paste: { visible: false },
        html: {
          visible: true,
          exec: function() {
            if (this.viewHTML) {
              this.setContent($(this.original).val());
              $(this.original).hide();
              $(this.editor).show();
            }
            else {
              this.saveContent();
              $(this.editor).hide();
              $(this.original).show().focus();
            }

            this.viewHTML = !( this.viewHTML );
          }
        }
      }
    });
  });

  $("div.wysiwyg iframe").live('focus', function () {
  });
})(jQuery);
