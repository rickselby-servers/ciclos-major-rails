// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// These are required in this order!
import "@popperjs/core"
import "bootstrap"
import "@rails/request.js"

// Font Awesome svg+js
import {far} from "@fortawesome/free-regular-svg-icons"
import {fas} from "@fortawesome/free-solid-svg-icons"
import {fab} from "@fortawesome/free-brands-svg-icons"
import {config as faconfig, library} from "@fortawesome/fontawesome-svg-core"
import "@fortawesome/fontawesome-free"
library.add(far, fas, fab)
faconfig.mutateApproach = 'sync'

import Cropper from "cropperjs";
window.Cropper = Cropper
