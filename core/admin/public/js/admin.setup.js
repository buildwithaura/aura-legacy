;(function ($) {
  $.uiscreen.background = "";
  $.uiscreen.opacity = 0.8;
  $.uiscreen.fadeout_time = 0;

  // Focus
  $("textarea, input, select")
    .live('focus', function () {
      $('body').find('.focus').removeClass('focus');
      $(this).closest('form p').addClass('focus');
    })
    .live('blur', function () {
      $(this).closest('form p').removeClass('focus');
    });

  // Preload of sorts
  $(function () { $("body").show().addClass("loaded"); });

  // Wysiwyg
  $("textarea.html, p.html textarea").livequery(function () {
    var $textarea = $(this);
    $(function(){ $textarea.auraWysiwyg(); });
  });

  $("div.wysiwyg iframe").livequery(function () {
    var $p = $(this).closest('p');
    var $form = $(this).closest('form');

    this.contentWindow.onfocus = function () {
      $form.find('.focus').removeClass('focus');
      $p.addClass('focus');
    };
    this.contentWindow.onblur = function () {
      //$p.removeClass('focus');
    };
  });

  $.fn.auraWysiwyg = function () {
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
            // Put the original inside.
            if (!$(this.original).closest('div.wysiwyg').length) {
              var $div = $(this.editor).closest('div.wysiwyg');
              $div.append($(this.original));
            }

            if (this.viewHTML) {
              this.setContent($(this.original).val());
              $(this.original).hide();
              $(this.editor).show();
              this.focus();
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
  };

  // How to:
  // - area_class 'editable-title'
  // - in the form, set the class to 'main-title' for the main title
  //
  // Set your form to have a class 'main-title' to have this cool thing here
  // 
  $("#area.editable-title p.main-title").livequery(function () {
    var $p     = $(this);
    var $input = $p.find('input');
    var $title = $("#title .title-c");
    var $label = $p.find('label');
    var $h1    = $title.find('h1');

    var $newInput = $("<input type='text'>");
    $newInput.attr('value', $input.val());
    $newInput.attr('placeholder', $label.text().replace(/^\s*|:?\s*$/g,'').replace(/\s+/g,' '));

    $h1.remove();
    $p.hide();

    $title.append($newInput);

    function onChange() {
      $input.val($newInput.val());
    };

    $newInput.bind('keypress blur change', onChange);
  });
})(jQuery);
