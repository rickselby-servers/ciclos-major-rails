import { Controller } from '@hotwired/stimulus'
import "tinymce"

export default class extends Controller {
    static targets = ['input']

    initialize() {
        this.defaults = {
            menubar: false,
            plugins: "link lists",
            toolbar: "undo redo | styles bold italic | numlist bullist | link blockquote",
            hidden_input: true,
            formats: {
                blockquote: {block: "blockquote", classes: "blockquote"},
            }
        }

        if (this.inputTarget.nodeName.toLowerCase() === "div") {
            this.defaults["inline"] = true;
            this.defaults["setup"] = function (editor) {
                editor.on("keyup", function (e) {
                    editor.selection.getNode().closest("form").querySelector("input[type=submit]").style.display = "inline-block";
                });
            }
        }
    }

    connect() {
        let config = Object.assign({ target: this.inputTarget }, this.defaults)
        tinymce.init(config)
    }

    disconnect() {
        tinymce.remove()
    }
}
