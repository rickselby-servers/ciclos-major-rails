# frozen_string_literal: true

require "rails_helper"

RSpec.describe "seasons/new" do
  let(:season) { Season.new }

  before { assign :season, season }

  it { is_expected.to have_link href: seasons_path }
  it { is_expected.to have_css "form[action='#{seasons_path}'][method='post']" }

  context "with the form" do
    subject { page.find("form") }

    it { is_expected.to have_field "season[name]" }
    it { is_expected.to have_field "season[description]" }
    it { is_expected.to have_field "season[photo]" }
    it { is_expected.to have_field "season[start_date]" }
    it { is_expected.to have_field "season[end_date]" }
    it { is_expected.to have_field "season[launch_date]" }
    it { is_expected.to have_button "commit" }
  end
end
