# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Pages" do
  describe "GET /" do
    it "returns http success" do
      get root_path
      expect(response).to be_successful
    end
  end

  PagesController::PAGES.each do |path|
    describe "GET /#{path}" do
      it "returns http success" do
        get public_send(:"#{path}_path")
        expect(response).to be_successful
      end
    end
  end
end
