# frozen_string_literal: true

require "rails_helper"

RSpec.describe "faqs/_faq" do
  let(:faq) { Faq.create! question: "Question", answer: "MyText" }
  let(:locals) { { faq: } }

  it { is_expected.to have_content "Question" }
  it { is_expected.to have_content "MyText" }

  it { is_expected.to have_no_link href: edit_faq_path(faq) }

  context "with html" do
    let(:faq) { Faq.create! question: "Question", answer: "<strong>MyText</strong>" }

    it { is_expected.to have_css "strong", text: "MyText" }
  end

  context "when logged in" do
    before { sign_in Admin.create }

    it { is_expected.to have_css ".sortable-handle" }
    it { is_expected.to have_link href: edit_faq_path(faq) }
  end
end
