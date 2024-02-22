# frozen_string_literal: true

require "rails_helper"

RSpec.describe "pages/contact_us.html.erb" do
  example { expect(render).to include "jotform" }
end
