# frozen_string_literal: true

require "rails_helper"

RSpec.describe "testimonials/_testimonial" do
  let(:testimonial) { create :testimonial }
  let(:locals) { { testimonial: } }

  it { is_expected.to have_content testimonial.title }
  it { is_expected.to have_content testimonial.text }

  it { is_expected.to have_no_link href: edit_testimonial_path(testimonial) }

  context "with html" do
    let(:testimonial) { create :testimonial, :html }

    it { is_expected.to have_css "strong", text: strip_tags(testimonial.text) }
  end

  context "when logged in", :logged_in do
    it { is_expected.to have_css ".sortable-handle" }
    it { is_expected.to have_link href: edit_testimonial_path(testimonial) }
  end
end
