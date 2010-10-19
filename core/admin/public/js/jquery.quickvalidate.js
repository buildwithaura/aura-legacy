;(function ($) {
  function validate($p, condition, type) {
    if (condition)
      { $p.removeClass('error'); $p.trigger('assert_ok', [type]); }
    else
      { $p.addClass('error'); $p.trigger('assert_error', [type]); }
  };

  $('form').live('submit', function (e) {
    if ($(this).find('.error').length) {
      $(this).find('.error').find('input, textarea, select').focus();
      $(this).trigger('submit_error');
      e.stopPropagation();
      return false;
    }
  });

  $('.assert.required *').live('change', function () {
    var $p = $(this).closest('.assert');
    validate($p, ($(this).val() != ''), 'required');
  });

  $('.assert.matches-next *').live('change', function () {
    var $p0 = $(this).closest('.assert');
    var $p1 = $p0.nextAll('.assert.matches-previous').first();

    var $input1 = $p1.find('input, textarea, select');
    var $input0 = $(this);

    if (($input1.val() == '') && ($input0.val() == '')) {
      validate($p0, true, 'matches');
      validate($p1, true, 'matches');
    }
    else if ($input1.val() != '') {
      validate($p0, ($input0.val() == $input1.val()), 'matches');
      validate($p1, ($input0.val() == $input1.val()), 'matches');
    }
  });

  $('.assert.matches-previous *').live('change', function () {
    var $p1 = $(this).closest('.assert');
    var $p0 = $p1.prevAll('.assert.matches-next').first();

    var $input0 = $p0.find('input, textarea, select');
    var $input1 = $(this);

    validate($p0, ($input0.val() == $input1.val()), 'matches');
    validate($p1, ($input0.val() == $input1.val()), 'matches');
  });

  /* Set up */

  $('p.assert').live('assert_error', function (e, type) {
    var msg = "";
    if (type == 'required') { msg = "Required"; }
    if (type == 'matches') { msg = "Doesn't match"; }

    var $n = $(this).find('.notice');

    if ($n.length)
      { $n.html(msg); }
    else {
      var t = $("<div class='notice'>" + msg + "</div>");
      $(this).append(t);
      t.hide().fadeIn();
    }
  });

  $('p.assert').live('assert_ok', function (e, type) {
    var $n = $(this).find('.notice');
    $(this).removeClass('error');
    if ($n) {
      $n.html("OK!");
      window.setTimeout(function () {
        $n.fadeOut(function () { $n.remove(); });
      }, 500);
    }
  });

  $('form').live('submit_error', function () {
    alert("Please check your form for errors.");
  });

})(jQuery);
