# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"

# Bootstrappy things
pin "@popperjs/core", to: "popper.js", preload: true
pin "bootstrap", preload: true
pin "font-awesome", to: "font-awesome-sass", preload: true

pin_all_from "app/javascript/controllers", under: "controllers"
