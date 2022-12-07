// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import FlashController from "./flash_controller"
import ModalController from "./modal_controller"
import UppyController from "./uppy_controller"
import FormSubmission from "./form"
import MarkerController from "./marker_controller"

application.register("flash", FlashController)
application.register("modal", ModalController)
application.register("uppy", UppyController)
application.register("form", FormSubmission)
application.register("marker", MarkerController)