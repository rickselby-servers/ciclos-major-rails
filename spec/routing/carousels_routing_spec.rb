# frozen_string_literal: true

require "rails_helper"

RSpec.describe CarouselsController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/carousels").to route_to("carousels#index")
    end

    it "routes to #show" do
      expect(get: "/carousels/1").to route_to("carousels#show", id: "1")
    end
  end
end
