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
end
