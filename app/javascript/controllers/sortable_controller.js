import { Controller } from '@hotwired/stimulus'
import Sortable from 'sortablejs'
import { patch } from '@rails/request.js'

// Connects to data-controller="sortable"
export default class extends Controller {
  static values = { endpoint: String }

  connect () {
    this.sortable = Sortable.create(this.element, {
      handle: '.sortable-handle',
      direction: 'vertical',
      ghostClass: 'bg-base-300',
      onEnd: this.onEnd.bind(this)
    })
  }

  async onEnd (event) {
    const items = this.sortable.toArray()
    const data = items.map((item, index) => {
      return { id: item, position: index }
    })
    const response = await patch(this.endpointValue, { body: { items: data } })

    if (!response.ok) {
      event.to.removeChild(event.item)
      event.to.insertBefore(event.item, event.to.children[event.oldIndex])
    }
  }
}
