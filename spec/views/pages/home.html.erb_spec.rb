# frozen_string_literal: true

require "rails_helper"
require_relative "basic_page"

RSpec.describe "pages/home.html.erb" do
  subject { render }

  it_behaves_like "it contains a page_text block", "pages.home.header"
  it_behaves_like "it contains a page_text block", "pages.home.block"
  it_behaves_like "it contains a page_text block", "pages.home.body"
end
