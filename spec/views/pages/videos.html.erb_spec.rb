# frozen_string_literal: true

require "rails_helper"
require_relative "basic_page"

RSpec.describe "pages/videos.html.erb" do
  subject { render }

  it { is_expected.to include "youtube" }
end
