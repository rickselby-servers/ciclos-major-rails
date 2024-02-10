# frozen_string_literal: true

class PagesController < ApplicationController
  PAGES = %w[
    about_us
    arrivals_and_transfers
    contact_us
    lunch_stops
    privacy_policy
    ride_groups
    routes
    safety
    terms_and_conditions
    videos
  ].freeze

  def home; end

  PAGES.each do |path|
    define_method(path) do
      # empty
    end
  end
end
