# frozen_string_literal: true

require "rails_helper"

RSpec.describe TestimonialsController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/testimonials").to route_to("testimonials#index")
    end

    it "routes to #new" do
      expect(get: "/testimonials/new").to route_to("testimonials#new")
    end

    it "routes to #edit" do
      expect(get: "/testimonials/1/edit").to route_to("testimonials#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/testimonials").to route_to("testimonials#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/testimonials/1").to route_to("testimonials#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/testimonials/1").to route_to("testimonials#update", id: "1")
    end

    it "routes to #move via PATCH" do
      expect(patch: "/testimonials/1/move").to route_to("testimonials#move", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/testimonials/1").to route_to("testimonials#destroy", id: "1")
    end
  end
end
