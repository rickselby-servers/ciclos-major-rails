# frozen_string_literal: true

require "rails_helper"

RSpec.describe "faqs/edit" do
  let(:faq) { create :faq }

  before { assign(:faq, faq) }

  it { is_expected.to have_link href: faqs_path }
  it { is_expected.to have_css "form[action='#{faq_path(faq)}'][method='post']" }

  context "with the form" do
    subject { page.find("form") }

    it { is_expected.to have_field "faq[question]" }
    it { is_expected.to have_field "faq[answer]" }
    it { is_expected.to have_button "commit" }
  end
end
