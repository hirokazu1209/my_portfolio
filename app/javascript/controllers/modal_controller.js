import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal"];

  conect() {
    console.log("Modal controller connected");
  }

  open() {
    this.modalTarget.classList.remove("hidden");
  }

  close() {
    this.modalTarget.classList.add("hidden");
  }

  autoClose() {
    this.open();
    setTimeout(() => {
      this.close();
    }, 2000);
  }
}