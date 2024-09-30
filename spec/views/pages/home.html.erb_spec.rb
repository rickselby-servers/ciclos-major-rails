# frozen_string_literal: true

require "rails_helper"

RSpec.describe "pages/home.html.erb" do
  it_behaves_like "it contains a page_text block", "pages.home.header"
  it_behaves_like "it contains a page_text block", "pages.home.block"
  it_behaves_like "it contains a page_text block", "pages.home.body"

  context "with a visible season" do
    let!(:season) { create :season }

    it { is_expected.to have_link href: season_path(season) }
  end
end
