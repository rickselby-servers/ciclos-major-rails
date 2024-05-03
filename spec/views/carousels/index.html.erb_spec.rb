# frozen_string_literal: true

require "rails_helper"

RSpec.describe "carousels/index" do
  let(:attributes) do
    {
      reference: "reference",
    }
  end
  let(:carousel) { create :carousel, **attributes }
  let(:carousel2) { create :carousel, **attributes }

  before { assign(:carousels, [carousel, carousel2]) }

  it { is_expected.to have_css "div > div > a > h2", text: "Reference", count: 2 }
end
