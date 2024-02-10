# frozen_string_literal: true

require "rails_helper"

RSpec.describe PageTextService, ".get_text" do
  subject(:get_text) { described_class.get_text key }

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
    before { PageText.create key:, text: }

    let(:text) { "some text" }

    it { is_expected.to eq text }

    context "with a default value" do
      subject(:get_text) { described_class.get_text key, default }

      let(:default) { :bar }

      it { is_expected.to eq text }
    end
  end
end
