import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="auto-submit"
export default class extends Controller {
  submit () {
    this.element.requestSubmit()
  }
}
