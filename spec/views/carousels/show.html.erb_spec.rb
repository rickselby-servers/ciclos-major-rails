# frozen_string_literal: true

require "rails_helper"

RSpec.describe "carousels/show" do
  let(:carousel) { create :carousel }

  before { assign :carousel, carousel }

  it { is_expected.to have_content carousel.reference }
end
