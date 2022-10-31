$(document).on("turbolinks:load", function () {
  $("#login_button").popup({
    on: "hover",
    popup: ".ui.popup.login_popup",
  });
  $("#login_button").on({
    mouseenter: function () {
      $("#login_button").on("click", function () {});
    },
  });

  if ($(".popup > .poprating").length) {
    $("a.ui.fluid.link.card.post.scale").popup({
      onShow: function () {
        const id = this.data("id");
        const rate_average = $(`#rate-${id}`).data("rating");
        $(`#rate-${id}`).raty({
          size: 36,
          starOff: "/star-off.png",
          starOn: "/star-on.png",
          starHalf: "/star-half.png",
          score: rate_average,
          half: true,
          readOnly: true,
        });
      },
    });
  }
});
