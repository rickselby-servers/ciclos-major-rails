import { Controller } from "@hotwired/stimulus"
import Cropper from "cropperjs"

// Connects to data-controller="cropper"
export default class extends Controller {
  initialize() {
    this.imageInput = this.element.querySelectorAll("[data-cropper-upload]")[0];
    this.croppableImage = this.element.querySelectorAll("[data-cropper-image]")[0];
    this.dataInput = this.element.querySelectorAll("[data-cropper-data]")[0];
    this.cancelButton = this.element.querySelectorAll("[data-cropper-cancel]")[0];
    this.previews = this.element.querySelectorAll(".previews");
    this.cropper = null;
  }

  connect() {
    this.imageInput.onchange = this.setup.bind(this);
    this.cancelButton.onclick = this.cancel;
  }

  disconnect() {
    this.destroy();
  }

  setup(event) {
    if (event.target.files && event.target.files.length) {
      let file = event.target.files[0];

      if (/^image\/\w+/.test(file.type)) {
        this.croppableImage.src = URL.createObjectURL(file);
        this.create();
      } else {
        window.alert("Please choose an image file.");
      }
    }
  }

  create() {
    this.destroy();
    this.cropper = new Cropper(this.croppableImage, {
      preview: this.previews,
      crop: this.crop.bind(this)
    });
  }

  crop(event) {
    this.dataInput.value = JSON.stringify(event.detail)
  }

  cancel() {
    this.imageInput.value = null;
    this.croppableImage.src = "";
  }

  destroy() {
    if (this.cropper) {
      this.cropper.destroy();
    }
  }
}
