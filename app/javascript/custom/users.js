$(function () {
  $('.close').click(function () {
    $('.flash-message').closest('.flash-message').transition('fade');
  })
});
