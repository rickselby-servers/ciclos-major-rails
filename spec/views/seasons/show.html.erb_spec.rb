# frozen_string_literal: true

require "rails_helper"

RSpec.describe "seasons/show" do
  let(:season) { create :season }

  before { assign :season, season }

  it { is_expected.to have_link href: edit_season_path(season) }
end
