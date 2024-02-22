# frozen_string_literal: true

require "rails_helper"

RSpec.describe EditableTextHelper, ".html" do
  subject(:html) { described_class.new(view, key, classes:).html }

  let(:classes) { [] }
  let(:key) { "foo.bar" }
  let(:text) { key }

  it { is_expected.to have_css "p#foo\\.bar", text: }

  context "with some content" do
    before { PageText.create key:, text: }

    let(:text) { "foo bar baz" }

    it { is_expected.to have_css "p#foo\\.bar", text: }
  end

  context "with given classes" do
    let(:classes) { %i[foo bar] }

    it { is_expected.to have_css "p.foo", text: }
    it { is_expected.to have_css "p.bar", text: }
  end

  context "when logged in" do
    before { sign_in Admin.create }

    it { is_expected.to have_css "form" }

    describe "the form contents" do
      subject { Capybara.string(html).find "form" }

      it { is_expected.to have_css "p#foo\\.bar", text: }
      it { is_expected.to have_button "Update", visible: :hidden }
    end
  end
end
