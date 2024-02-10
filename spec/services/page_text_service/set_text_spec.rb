# frozen_string_literal: true

require "rails_helper"

RSpec.describe PageTextService, ".set_text" do
  subject(:set_text) { described_class.set_text page_text, text }

  let(:key) { :foo }
  let(:page_text) { PageText.new key: }
  let(:text) { "bar" }

  context "with no existing record" do
    it "creates a new record" do
      set_text
      expect(PageText.count).to eq 1
    end

    it "sets the key" do
      set_text
      expect(PageText.first.key).to eq key.to_s
    end

    it "sets the text" do
      set_text
      expect(PageText.first.text).to eq text
    end
  end

  context "with a record for the key" do
    before { page_text.save }

    it "does not create another record" do
      set_text
      expect(PageText.count).to eq 1
    end

    it "updates the text" do
      set_text
      expect(PageText.first.reload.text).to eq text
    end
  end
end
