# frozen_string_literal: true

require "rails_helper"

RSpec.describe "seasons/index" do
  let(:attributes) { { name: "Specialities" } }
  let(:season) { create :season, **attributes }
  let(:season2) { create :season, **attributes }

  before { assign(:seasons, [season, season2]) }

  context "when logged in", :logged_in do
    it { is_expected.to have_link href: new_season_path }

    it { is_expected.to have_css "table > tbody > tr > th", text: attributes[:name], count: 2 }
  end
end
