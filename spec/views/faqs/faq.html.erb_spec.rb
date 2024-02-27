# frozen_string_literal: true

require "rails_helper"

RSpec.describe "faqs/_faq" do
  let(:faq) { create(:faq) }
  let(:locals) { { faq: } }

  it { is_expected.to have_content faq.question }
  it { is_expected.to have_content faq.answer }

  it { is_expected.to have_no_link href: edit_faq_path(faq) }

  context "with html" do
    let(:faq) { create(:faq, :html) }

    it { is_expected.to have_css "strong", text: strip_tags(faq.answer) }
  end

  context "when logged in", :logged_in do
    it { is_expected.to have_css ".sortable-handle" }
    it { is_expected.to have_link href: edit_faq_path(faq) }
  end
end
