# frozen_string_literal: true

require "rails_helper"

RSpec.describe "faqs/index" do
  let(:attributes) { { question: "Question", answer: "MyText" } }
  let(:faq) { create :faq, **attributes }
  let(:faq2) { create :faq, **attributes }

  before { assign(:faqs, [faq, faq2]) }

  it { is_expected.to have_css "div > div > h2 > div > button", text: attributes[:question], count: 2 }
  it { is_expected.to have_css "div > div > div > div", text: attributes[:answer], count: 2 }

  it { is_expected.to have_no_link href: new_faq_path }

  context "when logged in", :logged_in do
    it { is_expected.to have_link href: new_faq_path }
  end
end
