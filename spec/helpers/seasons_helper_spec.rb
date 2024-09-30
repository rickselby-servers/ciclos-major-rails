# frozen_string_literal: true

require "rails_helper"

RSpec.describe SeasonsHelper do
  describe ".season_status" do
    subject { helper.season_status season }

    shared_examples "when season is sold out" do
      before { season.update sold_out: true }

      it { is_expected.to have_text I18n.t("seasons.sold_out") }
    end

    context "when season is in the future" do
      let(:season) { create :season, :future }

      it { is_expected.to have_text I18n.t("seasons.future") }

      include_examples "when season is sold out"
    end

    context "when season has been launched" do
      let(:season) { create :season, :launched }

      it { is_expected.to have_text I18n.t("seasons.launched") }

      include_examples "when season is sold out"
    end

    context "when season is active" do
      let(:season) { create :season }

      it { is_expected.to have_text I18n.t("seasons.active") }

      include_examples "when season is sold out"
    end

    context "when season has finished" do
      let(:season) { create :season, :past }

      it { is_expected.to have_text I18n.t("seasons.finished") }

      include_examples "when season is sold out"
    end
  end

  describe ".seasons_for_home_page" do
    subject { helper.seasons_for_home_page }

    context "with no seasons" do
      it { is_expected.to be_empty }
    end

    context "with a past season" do
      before { create :season, :past }

      it { is_expected.to be_empty }
    end

    context "with a season yet to be launched" do
      before { create :season, :future }

      it { is_expected.to be_empty }
    end

    context "with a launched season" do
      let!(:season) { create :season, :launched }

      it { is_expected.to contain_exactly(season) }
    end

    context "with an active season" do
      let!(:season) { create :season }

      it { is_expected.to contain_exactly(season) }
    end

    context "with more than 4 seasons" do
      before { create_list :season, 5 }

      it { is_expected.to have_attributes size: 4 }
    end
  end
end
