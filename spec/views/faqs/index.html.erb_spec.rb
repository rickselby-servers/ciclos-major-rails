# frozen_string_literal: true

require "rails_helper"

RSpec.describe "faqs/index" do
  let(:faq) { create(:faq, question: "Question", answer: "MyText") }
  let(:faq2) { create(:faq, question: "Question", answer: "MyText") }

  before { assign(:faqs, [faq, faq2]) }

  it { is_expected.to have_css "div > div > h2 > div > button", text: "Question", count: 2 }
  it { is_expected.to have_css "div > div > div > div", text: "MyText", count: 2 }

  it { is_expected.to have_no_link href: new_faq_path }

  context "when logged in", :logged_in do
    it { is_expected.to have_link href: new_faq_path }
  end
end
