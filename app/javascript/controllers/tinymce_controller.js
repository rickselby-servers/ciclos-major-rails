import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
    static targets = ['input']

    initialize() {
        this.defaults = {
            menubar: false,
            inline: true,
            plugins: "link lists",
            toolbar: "undo redo | styles bold italic | numlist bullist | link blockquote",
            valid_elements: "h?,p,br,strong,em,a[href],ul,li,blockquote[class]",
            hidden_input: true,
            formats: {
                blockquote: {block: "blockquote", classes: "blockquote"},
            },
            setup: function (editor) {
                editor.on("keyup", function (e) {
                    editor.selection.getNode().closest("form").querySelector("input[type=submit]").style.display = "inline-block";
                });
            },
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