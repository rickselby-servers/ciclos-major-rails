# frozen_string_literal: true

require "rails_helper"

RSpec.describe "pages/routes.html.erb" do
  it_behaves_like "it contains a title and an body", "pages.routes"
end
