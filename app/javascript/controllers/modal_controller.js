import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["background", "content"];

  conect() {
    this.show()
  }

  show() {
    this.backgroundTarget.classList.remove("hidden")
    this.contentTarget.classList.remove("hidden")
  }

  hide() {
    this.backgroundTarget.classList.add("hidden")
    this.contentTarget.classList.add("hidden")
  }
}