import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static outlets = ["checkbox"]

  connect() {
    console.log("MarkerController#connect")
  }

  click() {
    this.checkboxOutlets.forEach((checkbox) => outlet.checked)
  }
}
