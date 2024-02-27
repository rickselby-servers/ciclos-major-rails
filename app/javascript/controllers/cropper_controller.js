import { Controller } from "@hotwired/stimulus"
import Cropper from "cropperjs"

// Connects to data-controller="cropper"
export default class extends Controller {
  connect() {
    let inputImage = this.element.querySelectorAll("[data-cropper-upload]")[0],
        croppableImage = this.element.querySelectorAll("[data-cropper-image]")[0],
        hiddenInput = this.element.querySelectorAll("[data-cropper-data]")[0];
    let cropper;

    inputImage.onchange = function () {
      if (this.files && this.files.length) {
        let file = this.files[0];

        if (/^image\/\w+/.test(file.type)) {
          croppableImage.src = URL.createObjectURL(file);

          if (cropper) {
            cropper.destroy();
          }

          cropper = new Cropper(croppableImage, {
            crop: function (event) {
              hiddenInput.value = JSON.stringify(event.detail)
            }
          });
        } else {
          window.alert("Please choose an image file.");
        }
      }
    }
  }
}
