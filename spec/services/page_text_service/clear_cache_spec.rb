# frozen_string_literal: true

require "rails_helper"

RSpec.describe PageTextService, ".clear_cache" do
  subject { described_class.get_text page_text.key }

  let!(:page_text) { create :page_text }

  context "without an update" do
    it { is_expected.to eq page_text.text }
  end

  context "when updating text" do
    before { described_class.set_text page_text, new_text }

    let(:new_text) { "baz" }

    it { is_expected.to eq new_text }
  end
end
