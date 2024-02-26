# frozen_string_literal: true

require "rails_helper"

RSpec.describe "faqs/new" do
  let(:faq) { Faq.new }

  before { assign(:faq, faq) }

  it { is_expected.to have_link href: faqs_path }
  it { is_expected.to have_css "form[action='#{faqs_path}'][method='post']" }

  context "with the form" do
    subject { page.find("form") }

    it { is_expected.to have_field "faq[question]" }
    it { is_expected.to have_field "faq[answer]" }
    it { is_expected.to have_button "commit" }
  end
end
