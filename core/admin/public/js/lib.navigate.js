// Swell navigation.
//
// Why you'd use it:
//
// - Say you have links to a page like `http://yoursite.com/admin/products`.
// - You want it so that clicking that link will in load the new page /in place/.
// - However, you want it so that the URL will also be accessible as
//   `http://yoursite.com/admin/products`.
//
// Usage:
//
//   /* Bind this to like, say, <a> links */
//   $.navigate('/admin/products');
//
//   $(window).bind('navigate', function (e, href) {
//     /* href == '/admin/products' */
//   });
//
// If the history states are available (Safari/FF4), it will change the actual URL
// of the page, yet still /not/ load the URL directly (but instead just trigger the
// `navigate` event).
//
// If history states are not available, it will fall back to hashListen.
//
;(function ($) {
  if (window.history.pushState) {
    $.navigate = function (href) {
      window.history.pushState({ href: href }, "", href);
      $(window).trigger('navigate', href);
    };

    window.onpopstate = function (e, state) {
      $(window).trigger('navigate', window.location.pathname);
    };
  }

  else {
    $.navigate = function (href) {
      if (window.location.hash == '#!'+href) { return; }
      window.location.hash = "#!" + href;
    };

    $.hashListen('!(.*)', function (href) {
      $(window).trigger('navigate', href);
    });
  };
})(jQuery);
