import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  connect() {
    let backdrop = document.querySelector(".modal-backdrop");
    if (backdrop) {
      backdrop.remove();
    }

    this.modal = new bootstrap.Modal(this.element);
    this.modal.show();

    this.element.addEventListener('hidden.bs.modal', this.hideModal.bind(this));
  }

  hideModal() {
    this.element.parentElement.removeAttribute("src");
    this.element.remove();
  }

  // hide modal on successful form submission
  // action: "turbo:submit-end->modal#submitEnd"
  submitEnd(e) {
    if (e.detail.success) {
      this.modal.hide();
    }
  }
}
