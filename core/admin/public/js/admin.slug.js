;(function ($) {
  $('.crumbs .url').live('click', function () {
    $(this).addClass('edit');
    $(this).find('input').focus();
  });

  $('.crumbs form.url').live('submit', function (e) {
    $(this).closest('.url').removeClass('edit');
    e.preventDefault(true);
  });

  $('.crumbs .url input').live('blur', function (e) {
    $(this).closest('.url').removeClass('edit');
    e.preventDefault(true);
  });

  $('.crumbs .url input').live('change', function (e) {
    var $input = $("#area form [name='editor[slug]']")
    if (!$input.length) { return; }

    var val = $(this).val();

    $input.val(val);

    var $slug = $(this).closest('.url').find('.this');
    if (val == '') { $slug.html("..."); }
    else { $slug.html(val); }

    e.preventDefault(true);
  });
})(jQuery);
