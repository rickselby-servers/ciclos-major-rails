# frozen_string_literal: true

RSpec.describe "Homes" do
  describe "GET /show" do
    it "returns http success" do
      get "/home/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/home/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/home/update"
      expect(response).to have_http_status(:success)
    end
  end
end
