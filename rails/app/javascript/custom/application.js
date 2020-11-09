$(document).on('turbolinks:load', function () {
  $('.close').click(function () {
    $('.flash-message').closest('.flash-message').transition('fade');
  });
  $('.ui.accordion').accordion();
  $('.sidebar.icon').on('click', function () {
    $('.ui.sidebar').sidebar('toggle');
  });
  $('.menu .item').tab();
  $('#dimmer-button').on('click', function () {
    $('#dimmer').dimmer('toggle');
    $('#dimmer-product').dimmer('toggle');
  });
  $('.sticky').sticky({
    context: '#sidebar'
  });
  $('.ui.dropdown').dropdown();
  $('.file-form').on('change', function () {
    $('#dimmer').dimmer('hide');
    $('#dimmer-product').dimmer('hide');
    var file = this.files[0];
    var reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = function () {
      var image = this.result;
      $('#img-prev').attr({ src: image });
    };
  });
  if ($('.page_next').length) {
    var InfiniteScroll = require('infinite-scroll');
    var infScroll = new InfiniteScroll('.scroll', {
      path: ".page_next",
      append: ".post",
      history: false,
      prefill: true,
      status: '.page-load-status',
      hideNav: ".pagination"
    });
    infScroll.on('request', function (path) {
      $('.ui.sticky').sticky('refresh');
    });
  };
  $('#rating').rating({
    maxRating: 5,
    onRate: function (rating) {
      $('#review_rate').val(rating)
    }
  });
  $('.read').rating('disable');
  if ($('#star').length) {
    $('#star').raty({
      size: 36,
      starOff: '/star-off.png',
      starOn: '/star-on.png',
      starHalf: '/star-half.png',
      score: gon.rate_average,
      half: true,
      readOnly: true
    });
  };
});