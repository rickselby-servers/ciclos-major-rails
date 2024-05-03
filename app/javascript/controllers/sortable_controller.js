import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs";
import { FetchRequest } from '@rails/request.js';

export default class extends Controller {
  static values = {
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
    const url = event.item.dataset.sortableUrl;
    const glue = url.includes("?") ? "&" : "?"
    const request = new FetchRequest('patch', `${url}${glue}from=${event.oldIndex}&to=${event.newIndex}`)
    await request.perform()
  }
}
