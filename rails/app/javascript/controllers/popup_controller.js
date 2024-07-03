import { Controller } from "@hotwired/stimulus";
import $ from "jquery";
// Connects to data-controller="popup"
export default class extends Controller {
  connect() {
    $("#login_button").popup({
      on: "hover",
      hoverable: true,
      popup: ".ui.popup.login_popup",
    });

    $(".rank-card").popup({
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

  loginshow() {
    $("#login_button").on("click");
  }
}
