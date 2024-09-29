# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Admins" do
  describe "GET /admin" do
    subject do
      get admin_path
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it { is_expected.to be_successful }
    end
  end
end
