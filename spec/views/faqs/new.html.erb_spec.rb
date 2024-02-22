# frozen_string_literal: true

require "rails_helper"
require_relative "../../support/view_helpers"

RSpec.describe "faqs/new" do
  include_context "with view rendering"

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

  it "renders new faq form" do
    p render

    assert_select "form[action=?][method=?]", faqs_path, "post" do
      assert_select "input[name=?]", "faq[question]"

      assert_select "textarea[name=?]", "faq[answer]"
    end
  end
end
