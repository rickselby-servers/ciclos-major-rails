# frozen_string_literal: true

RSpec.describe "Home" do
  describe "GET show" do
    it "returns http success" do
      get home_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get edit_home_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT update" do
    it "returns http success" do
      put home_path
      expect(response).to have_http_status(:success)
    end
  end
end
