;(function ($) {
  $('.crumbs .url, .crumbs. url a').live('click', function () {
    var $url = $(this).closest('.url');
    $url.addClass('edit');
    $url.find('input').focus();
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
