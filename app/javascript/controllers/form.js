import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  initialize() {
    this.submit = debounce(this.submit.bind(this), 300)
  }

  connect() {
    console.log("Form#connect")
  }

  submit() {
    this.element.requestSubmit()
  }
}
