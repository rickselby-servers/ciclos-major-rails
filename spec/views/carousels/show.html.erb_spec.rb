# frozen_string_literal: true

require "rails_helper"

RSpec.describe "carousels/show" do
  let(:carousel_model) { create :carousel }

  before { assign :carousel, carousel_model }

  it { is_expected.to have_content carousel_model.name }
end
