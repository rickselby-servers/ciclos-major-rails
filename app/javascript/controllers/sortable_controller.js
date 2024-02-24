import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs";
import { FetchRequest } from '@rails/request.js';

// Connects to data-controller="sortable"
export default class extends Controller {
  static values = {
    url: String,
    handle: String
  }

  connect() {
    this.sortable = Sortable.create(this.element, {
      animation: 150,
      handle: this.handleValue,
      onEnd: this.end.bind(this)
    })
  }

  async end(event) {
    const request = new FetchRequest('patch', `${this.urlValue}?old_position=${event.oldIndex + 1}&new_position=${event.newIndex + 1}`)
    await request.perform()
  }
}
