# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/carousels" do
  let(:carousel) { create :carousel }

  describe "GET /index" do
    subject do
      get carousels_path
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it { is_expected.to be_successful }
    end
  end

  describe "GET /show" do
    subject do
      get carousel_path(carousel)
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it { is_expected.to be_successful }
    end
  end
end
