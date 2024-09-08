# frozen_string_literal: true

class BikeRentalDetail < ApplicationRecord
  belongs_to :bike_rental

  acts_as_list top_of_list: 0
  audited

  validates :key, presence: true
  validates :value, presence: true

  scope :ordered, -> { order :position }
end
