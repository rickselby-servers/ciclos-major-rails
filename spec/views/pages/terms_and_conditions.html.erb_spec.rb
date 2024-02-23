# frozen_string_literal: true

require "rails_helper"

RSpec.describe "pages/terms_and_conditions.html.erb" do
  it_behaves_like "it contains a title and an body", "pages.terms_and_conditions"
end
