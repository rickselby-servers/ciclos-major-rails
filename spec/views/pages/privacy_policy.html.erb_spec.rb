# frozen_string_literal: true

require "rails_helper"

RSpec.describe "pages/privacy_policy.html.erb" do
  it_behaves_like "it contains a title and an body", "pages.privacy_policy"
end
