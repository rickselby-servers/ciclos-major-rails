# frozen_string_literal: true

require "rails_helper"
require_relative "basic_page"

RSpec.describe "pages/ride_groups.html.erb" do
  subject { render }

  it_behaves_like "it contains a title and an body", "pages.ride_groups"
end
