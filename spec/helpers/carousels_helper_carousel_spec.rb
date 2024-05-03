# frozen_string_literal: true

require "rails_helper"

RSpec.describe CarouselsHelper, ".carousel" do
  subject(:render_carousel) { helper.carousel(reference) }

  let(:reference) { "carousel-reference" }

  context "when the referenced carousel does not exist" do
    it "creates a new carousel" do
      render_carousel
      expect(Carousel.count).to eq 1
    end
  end

  context "when the referenced carousel already exists" do
    before { create :carousel, reference: }

    it "does not create a new carousel" do
      render_carousel
      expect(Carousel.count).to eq 1
    end
  end
end
