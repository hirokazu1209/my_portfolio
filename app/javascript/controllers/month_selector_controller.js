import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["select"];

  change() {
    const targetMonth = this.selectTarget.value;
    const url = `/items?target_month=${targetMonth}`;

    fetch(url, {
      headers: { "Accept": "text/vnd.turbo-stream.html" }
    })
      .then(response => response.text())
      .then(html => {
        document.getElementById("items-list").innerHTML = html;
      });
  }
}