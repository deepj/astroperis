import { Controller } from "@hotwired/stimulus"
import { FileInput, Informer, ProgressBar } from "uppy"
import { uppyInstance, uploadedFileData } from "../uppy"

export default class extends Controller {
  static targets = [ "input", "result" ]
  static values = { types: Array, server: String }

  connect() {
    this.inputTarget.classList.add("d-none")

    this.uppy = this.createUppy()
  }

  disconnect() {
    this.uppy.close()
  }

  createUppy() {
    const uppy = uppyInstance({
        id: this.inputTarget.id,
        types: this.typesValue,
        server: this.serverValue,
      })
      .use(FileInput, {
        target: this.inputTarget.parentNode,
        locale: { strings: { chooseFiles: 'Choose file' } },
      })
      .use(Informer, {
        target: this.inputTarget.parentNode,
      })
      .use(ProgressBar, {
        target: this.resultTarget.parentNode,
      })

    uppy.on('upload-success', (file, response) => {
      // set hidden field value to the uploaded file data so that it's submitted with the form as the attachment
      this.resultTarget.value = uploadedFileData(file, response, this.serverValue)
    })

    return uppy
  }
}
