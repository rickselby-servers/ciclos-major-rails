# frozen_string_literal: true

require "rails_helper"

RSpec.describe "pages/videos.html.erb" do
  example { expect(render).to include "youtube" }
end
