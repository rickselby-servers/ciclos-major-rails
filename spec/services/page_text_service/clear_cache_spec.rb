# frozen_string_literal: true

require "rails_helper"

RSpec.describe PageTextService, ".clear_cache" do
  subject { described_class.get_text key }

  let(:key) { :foo }
  let!(:page_text) { PageText.create key:, text: }
  let(:text) { "bar" }

  context "without an update" do
    it { is_expected.to eq text }
  end

  context "when updating text" do
    before { described_class.set_text page_text, new_text }

    let(:new_text) { "baz" }

    it { is_expected.to eq new_text }
  end
end
