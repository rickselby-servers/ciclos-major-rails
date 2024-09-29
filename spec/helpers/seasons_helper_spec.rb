# frozen_string_literal: true

require "rails_helper"

RSpec.describe SeasonsHelper do
  describe ".season_status" do
    subject { helper.season_status season }

    context "when season is in the future" do
      let(:season) { create :season, :future }

      it { is_expected.to have_text I18n.t("seasons.future") }
    end

    context "when season has been launched" do
      let(:season) { create :season, :launched }

      it { is_expected.to have_text I18n.t("seasons.launched") }
    end

    context "when season is active" do
      let(:season) { create :season }

      it { is_expected.to have_text I18n.t("seasons.active") }
    end

    context "when season has finished" do
      let(:season) { create :season, :past }

      it { is_expected.to have_text I18n.t("seasons.finished") }
    end
  end
end
