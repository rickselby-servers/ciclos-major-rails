# frozen_string_literal: true

require "rails_helper"

RSpec.describe "testimonials/index" do
  let(:testimonial) { create :testimonial, title: "Title", text: "MyText" }
  let(:testimonial2) { create :testimonial, title: "Title", text: "MyText" }

  before { assign(:testimonials, [testimonial, testimonial2]) }

  it { is_expected.to have_css "div > div > h4", text: "Title", count: 2 }
  it { is_expected.to have_css "div > div > p", text: "MyText", count: 2 }

  it { is_expected.to have_no_link href: new_testimonial_path }

  context "when logged in", :logged_in do
    it { is_expected.to have_link href: new_testimonial_path }
  end
end
