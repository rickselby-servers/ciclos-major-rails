import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  connect() {
    let backdrop = document.querySelector(".modal-backdrop");
    if (backdrop) {
      backdrop.remove();
    }

    let modal = new bootstrap.Modal(this.element);
    modal.show();

    this.element.addEventListener('hidden.bs.modal', (event) => {
      this.element.parentElement.removeAttribute("src")
      this.element.remove();
    })
  }
}
