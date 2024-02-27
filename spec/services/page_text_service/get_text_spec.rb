# frozen_string_literal: true

require "rails_helper"

RSpec.describe PageTextService, ".get_text" do
  subject(:get_text) { described_class.get_text key }

  let(:default) { :bar }
  let(:key) { :foo }

  context "with no record" do
    it "does not create a new record" do
      get_text
      expect(PageText.count).to eq 0
    end

    it { is_expected.to eq key }

    context "with a default value" do
      subject(:get_text) { described_class.get_text key, default }

      let(:default) { :bar }

      it { is_expected.to eq default }
    end
  end

  context "with a record for the key" do
    let!(:page_text) { create(:page_text) }

    it { is_expected.to eq page_text.text }

    context "with a default value" do
      subject(:get_text) { described_class.get_text page_text.key, default }

      it { is_expected.to eq page_text.text }
    end
  end
end
