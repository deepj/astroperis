import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("ModalController connected")
    this.modal = this.element
  }

  open() {
    console.log("ModalController open")
    console.log(this.modal.isOpened)
    console.log(this.modal)

    if (!this.modal.isOpened) this.modal.showModal()
  }

  close(event) {
    this.modal.close()
  }
}
