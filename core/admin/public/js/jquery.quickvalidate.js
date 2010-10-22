;(function ($) {
  $.qvalidate = function() {};

  function validate($p, condition, type) {
    var data = ($p.data('assert_data') || {});

    if (data.status != 'error') {
      data.type = type;
      data.status = condition ? 'ok' : 'error';
    }

    $p.data('assert_data', data);
  };

  $('form').live('submit', function (e) {
    $(this).find('input, textarea, select').trigger('blur');

    if ($(this).find('.error').length) {
      $(this).trigger('submit_error');
      $(this).find('.error').find('input, textarea, select').first().focus();
      e.stopPropagation();
      return false;
    }
  });

  $('.assert').find('input, textarea, select').live('blur', function () {
    var $p = $(this).closest('.assert');
    $p.trigger('validate', [$(this)]);

    var data = ($p.data('assert_data') || {});

    if (data.status == 'error') {
      $p.addClass('error');
      $p.trigger('assert_error', [data.type]);
    } else {
      $p.removeClass('error');
      $p.trigger('assert_ok', [data.type]);
    }

    $p.data('assert_data', null);
  });

  $('.assert.required, .assert.present').live('validate', function (e, $input) {
    validate($(this), ($input.val() != ''), 'required');
  });

  $('.assert.matches-next').live('validate', function () {
    var $p0 = $(this);
    var $p1 = $p0.nextAll('.assert.matches-previous').first();

    var $input1 = $p1.find('input, textarea, select');
    var $input0 = $p0.find('input');

    if (($input1.val() != '') || ($input0.val() == '')) {
      $input1.trigger('blur');
    }
  });

  $('.assert.matches-previous').live('validate', function () {
    var $p1 = $(this);
    var $p0 = $p1.prevAll('.assert.matches-next').first();

    var $input0 = $p0.find('input, textarea, select');
    var $input1 = $p1.find('input');

    var condition = ($input0.val() == $input1.val());
    validate($p1, condition, 'matches');
  });

  /* Set up */

  function onAssertError (e, type) {
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
  };

  function onAssertOk (e, type) {
    var $n = $(this).find('.notice');
    $(this).removeClass('error');
    if ($n) {
      $n.html("OK!");
      window.setTimeout(function () {
        $n.fadeOut(function () { $n.remove(); });
      }, 500);
    }
  };

  function onSubmitError () {
    alert("Please check your form for errors.");
  };

  function bindDefaults() {
    $('.assert')
      .live('assert_error', onAssertError)
      .live('assert_ok',    onAssertOk);

    $('form').live('submit_error', onSubmitError);
  }

  function unbindDefaults() {
    $('.assert')
      .die('assert_error', onAssertError)
      .die('assert_ok',    onAssertOk);

    $('form').die('submit_error', onSubmitError);
  }

  bindDefaults();

  // Export
  $.qvalidate.validate = validate;
  $.qvalidate.unbindDefaults = unbindDefaults;
})(jQuery);
