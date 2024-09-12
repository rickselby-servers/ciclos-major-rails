# frozen_string_literal: true

require "rails_helper"

RSpec.describe "carousels/index" do
  let(:attributes) { { reference: "reference" } }
  let(:carousel_model) { create :carousel, **attributes }
  let(:carousel_model2) { create :carousel, **attributes }

  before { assign(:carousels, [carousel_model, carousel_model2]) }

  it { is_expected.to have_css "ul > li > a", text: attributes[:reference], count: 2 }
end
