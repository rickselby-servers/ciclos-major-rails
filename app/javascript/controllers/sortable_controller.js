import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs";
import { FetchRequest } from '@rails/request.js';

export default class extends Controller {
  static values = {
    url: String,
    handle: String
  }

  connect() {
    this.sortable = Sortable.create(this.element, {
      animation: 150,
      handle: this.handleValue,
      ghostClass: "sortable-ghost",
      onEnd: this.end.bind(this)
    })
  }

  async end(event) {
    console.log(this.urlValue);
    console.log(`${this.urlValue}&from=${event.oldIndex}&to=${event.newIndex}`);
    const glue = this.urlValue.includes("?") ? "&" : "?"
    const request = new FetchRequest('patch', `${this.urlValue}${glue}from=${event.oldIndex}&to=${event.newIndex}`)
    await request.perform()
  }
}
