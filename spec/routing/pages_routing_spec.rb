# frozen_string_literal: true

require "rails_helper"

RSpec.describe PagesController do
  describe "routing" do
    it "routes to #home" do
      expect(get: "/").to route_to("pages#home")
    end

    PagesController::PAGES.each do |page|
      it "routes to #{page}" do
        expect(get: "/#{page.dasherize}").to route_to("pages##{page}")
      end
    end
  end
end
