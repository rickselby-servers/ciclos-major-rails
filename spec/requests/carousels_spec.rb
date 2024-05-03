# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/carousels" do
  let(:carousel) { create :carousel }

  describe "GET /index" do
    subject do
      get carousels_path
      response
    end

    it { is_expected.to be_successful }
  end

  describe "GET /show" do
    subject do
      get carousel_path(carousel)
      response
    end

    it { is_expected.to be_successful }
  end
end
