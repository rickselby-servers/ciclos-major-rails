# frozen_string_literal: true

require "rails_helper"

RSpec.describe "pages/ride_groups.html.erb" do
  it_behaves_like "it contains a title and an body", "pages.ride_groups"
end
