# frozen_string_literal: true

require "rails_helper"

shared_examples "it contains a page_text block" do |key|
  before { PageText.create key:, text: }

  let(:text) { SecureRandom.alphanumeric 32 }

  it { is_expected.to include text }
end

shared_examples "it contains a title and an body" do |key|
  it_behaves_like "it contains a page_text block", "#{key}.title"
  it_behaves_like "it contains a page_text block", "#{key}.body"
end
