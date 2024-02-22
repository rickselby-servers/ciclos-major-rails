# frozen_string_literal: true

require "rails_helper"
require_relative "../../support/view_helpers"

RSpec.describe "faqs/_faq" do
  include_context "with view rendering"

  let(:faq) { Faq.create! question: "Question", answer: "MyText" }
  let(:locals) { { faq: } }

  it { is_expected.to have_content "Question" }
  it { is_expected.to have_content "MyText" }

  it { is_expected.to have_no_link href: edit_faq_path(faq) }

  context "when logged in" do
    before { sign_in Admin.create }

    it { is_expected.to have_link href: edit_faq_path(faq) }
  end
end
