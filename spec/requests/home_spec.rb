# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Home" do
  describe "GET show" do
    it "returns http success" do
      get home_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET edit" do
    it "returns http success" do
      pending "auth"

      get edit_home_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT update" do
    it "returns http success" do
      pending "auth"

      put home_path
      expect(response).to have_http_status(:success)
    end
  end
end
