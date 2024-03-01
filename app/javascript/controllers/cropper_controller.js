import { Controller } from "@hotwired/stimulus"
import Cropper from "cropperjs"

// Connects to data-controller="cropper"
export default class extends Controller {
  static targets = [ "imageInput", "dataInput", "croppableImage", "preview" ];

  connect() {
    this.cropper = null;
  }

  disconnect() {
    this.destroy();
  }

  setup(event) {
    if (event.target.files && event.target.files.length) {
      let file = event.target.files[0];

      if (/^image\/\w+/.test(file.type)) {
        this.croppableImageTarget.src = URL.createObjectURL(file);
        this.showPreviews();
        this.create();
      } else {
        window.alert("Please choose an image file.");
      }
    }
  }

  create() {
    this.destroy();
    this.cropper = new Cropper(this.croppableImageTarget, {
      preview: this.previewTargets,
      viewMode: 2,
      scalable: false,
      autoCropArea: 1,
      crop: this.crop.bind(this)
    });
  }

  crop(event) {
    this.dataInputTarget.value = JSON.stringify(event.detail)
  }

  rotate({ params: { degrees }}) {
    this.cropper.rotate(degrees);
  }

  zoom({ params: { scale }}) {
    this.cropper.zoom(scale);
  }

  reset() {
    this.cropper.reset();
  }

  cancel() {
    this.imageInputTarget.value = null;
    this.croppableImageTarget.src = "";
    this.destroy();
    this.hidePreviews();
  }

  destroy() {
    if (this.cropper) {
      this.cropper.destroy();
    }
  }

  showPreviews() {
    this.previewTargets.forEach((element) => {
      element.style.display = "inline-block";
      element.style.width = "200px";
      element.style.height = "1000px";
    });
  }

  hidePreviews() {
    this.previewTargets.forEach((element) => {
      element.style.display = "inline-block";
      element.style.width = "auto";
      element.style.height = "auto";
    });
  }
}
