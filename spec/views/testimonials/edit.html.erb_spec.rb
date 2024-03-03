# frozen_string_literal: true

require "rails_helper"

RSpec.describe "testimonials/edit" do
  let(:testimonial) { create :testimonial }

  before { assign(:testimonial, testimonial) }

  it { is_expected.to have_link href: testimonials_path }
  it { is_expected.to have_css "form[action='#{testimonial_path(testimonial)}'][method='post']" }

  context "with the form" do
    subject { page.find("form") }

    it { is_expected.to have_field "testimonial[title]" }
    it { is_expected.to have_field "testimonial[text]" }
    it { is_expected.to have_button "commit" }
  end
end
