import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs";
import { FetchRequest } from '@rails/request.js';

// Connects to data-controller="sortable"
export default class extends Controller {
  static values = {
    url: String,
    test: String
  }

  connect() {
    console.log("Sortable controller connected");
    this.sortable = Sortable.create(this.element, {
      animation: 150,
      onEnd: this.end.bind(this)
    })
  }

  async end(event) {
    console.log("Sortable onEnd triggered")

    const request = new FetchRequest('patch', `${this.urlValue}?old_position=${event.oldIndex + 1}&new_position=${event.newIndex + 1}`)
    const response = await request.perform()
    console.log(response)
  }
}
