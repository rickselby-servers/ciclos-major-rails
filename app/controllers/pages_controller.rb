# frozen_string_literal: true

class PagesController < ApplicationController
  PAGES = %w[
    about-us
    arrivals-and-transfers
    contact-us
    lunch-stops
    privacy-policy
    ride-groups
    routes
    safety
    terms-and-conditions
    videos
  ].freeze

  def home; end

  PAGES.each do |path|
    define_method(path.underscore) do
      # empty
    end
  end
end
