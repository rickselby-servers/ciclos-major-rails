# frozen_string_literal: true

require "rails_helper"

RSpec.describe "pages/home.html.erb" do
  it_behaves_like "it contains a page_text block", "pages.home.header"
  it_behaves_like "it contains a page_text block", "pages.home.block"
  it_behaves_like "it contains a page_text block", "pages.home.body"
end
