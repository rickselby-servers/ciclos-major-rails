# frozen_string_literal: true

require "rails_helper"
require_relative "shared/resize_image"

RSpec.describe BikeRental do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to validate_presence_of :photo }

  it { is_expected.to be_audited }
  it { is_expected.to have_one_attached :photo }

  it_behaves_like "it resizes an image correctly",
                  :photo,
                  { "400x400" => [400, 400], "1000x2000" => [856, 1712], "2000x1000" => [856, 428] }

  it { is_expected.to have_many :bike_rental_details }
  it { is_expected.to accept_nested_attributes_for :bike_rental_details }
end
