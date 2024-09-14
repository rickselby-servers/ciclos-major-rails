# frozen_string_literal: true

class BikeRentalPrice < ApplicationRecord
  belongs_to :bike_rental

  audited

  validates :days, presence: true, numericality: { only_integer: true }, uniqueness: { scope: :bike_rental_id }
  validates :total_price, presence: true, numericality: { only_integer: true }

  scope :ordered, -> { order :days }

  def price_per_day
    total_price.fdiv days
  end
end
