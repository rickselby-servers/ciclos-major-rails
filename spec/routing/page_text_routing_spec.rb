# frozen_string_literal: true

require "rails_helper"

RSpec.describe PageTextController do
  describe "routing" do
    it "routes to #update via PUT" do
      expect(put: "/page_text/1").to route_to("page_text#update", id: "1")
    end
  end
end
