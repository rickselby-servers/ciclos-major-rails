# frozen_string_literal: true

require "rails_helper"

RSpec.describe EditableTextHelper, ".html" do
  subject(:html) { described_class.new(view, key, classes:).html }

  let(:classes) { [] }
  let(:key) { "foo.bar" }
  let(:text) { key }

  it { is_expected.to have_css "div#foo\\.bar", text: }

  context "with some content" do
    let!(:page_text) { create :page_text, key: }

    it { is_expected.to have_css "div#foo\\.bar", text: page_text.text }
  end

  context "with HTML" do
    let!(:page_text) { create :page_text, :html, key: }

    it { is_expected.to have_css "div#foo\\.bar strong", text: strip_tags(page_text.text) }
  end

  context "with given classes" do
    let(:classes) { %i[foo bar] }

    it { is_expected.to have_css "div.foo", text: }
    it { is_expected.to have_css "div.bar", text: }
  end

  context "when logged in", :logged_in do
    it { is_expected.to have_css "form" }

    describe "the form contents" do
      subject { Capybara.string(html).find "form" }

      it { is_expected.to have_css "div#foo\\.bar", text: }
      it { is_expected.to have_button "Update", visible: :hidden }
    end
  end
end
