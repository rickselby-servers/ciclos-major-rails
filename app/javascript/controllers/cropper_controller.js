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
    this.rotateButtons = this.element.querySelectorAll("[data-cropper-rotate]");
    this.cropper = null;
  }

  connect() {
    this.imageInput.onchange = this.setup.bind(this);
    this.cancelButton.onclick = this.cancel.bind(this);
    this.rotateButtons.forEach((button) => {
      button.onclick = this.rotate.bind(this);
    });
  }

  disconnect() {
    this.destroy();
  }

  setup(event) {
    if (event.target.files && event.target.files.length) {
      let file = event.target.files[0];

      if (/^image\/\w+/.test(file.type)) {
        this.croppableImage.src = URL.createObjectURL(file);
        this.showPreviews();
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

  rotate(event) {
    this.cropper.rotate(event.currentTarget.dataset.cropperRotate);
  }

  cancel() {
    this.imageInput.value = null;
    this.croppableImage.src = "";
    this.destroy();
    this.hidePreviews();
  }

  destroy() {
    if (this.cropper) {
      this.cropper.destroy();
    }
  }

  showPreviews() {
    this.previews.forEach((element) => {
      element.style.display = "inline-block";
      element.style.width = "200px";
      element.style.height = "1000px";
    });
  }

  hidePreviews() {
    this.previews.forEach((element) => {
      element.style.display = "inline-block";
      element.style.width = "auto";
      element.style.height = "auto";
    });
  }
}
