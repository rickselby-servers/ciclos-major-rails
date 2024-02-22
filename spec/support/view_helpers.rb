# frozen_string_literal: true

# Helpers for view spec tests
module ViewHelpers
  shared_context "with view rendering" do
    subject(:page) { Capybara.string render(locals:) }

    let(:locals) { {} }
  end

  shared_examples "it contains a title and an body" do |key|
    it_behaves_like "it contains a page_text block", "#{key}.title"
    it_behaves_like "it contains a page_text block", "#{key}.body"
  end

  shared_examples "it contains a page_text block" do |key|
    before { PageText.create key:, text: }

    let(:text) { SecureRandom.alphanumeric 32 }

    it { is_expected.to have_content text }
  end
end
