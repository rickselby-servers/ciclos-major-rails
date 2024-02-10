# frozen_string_literal: true

require "rails_helper"
require_relative "basic_page"

RSpec.describe "pages/arrivals_and_transfers.html.erb" do
  subject { render }

  it_behaves_like "it contains a title and an body", "pages.arrivals_and_transfers"
end
