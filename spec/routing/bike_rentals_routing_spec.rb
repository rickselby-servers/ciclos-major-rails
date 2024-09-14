# frozen_string_literal: true

require "rails_helper"

RSpec.describe BikeRentalsController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/bike_rentals").to route_to("bike_rentals#index")
    end

    it "routes to #new" do
      expect(get: "/bike_rentals/new").to route_to("bike_rentals#new")
    end

    it "routes to #edit" do
      expect(get: "/bike_rentals/1/edit").to route_to("bike_rentals#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/bike_rentals").to route_to("bike_rentals#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/bike_rentals/1").to route_to("bike_rentals#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/bike_rentals/1").to route_to("bike_rentals#update", id: "1")
    end

    it "routes to #move via PATCH" do
      expect(patch: "/bike_rentals/1/move").to route_to("bike_rentals#move", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/bike_rentals/1").to route_to("bike_rentals#destroy", id: "1")
    end
  end
end
