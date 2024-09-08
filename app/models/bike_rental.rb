# frozen_string_literal: true

class BikeRental < ApplicationRecord
  include ResizeImage

  acts_as_list top_of_list: 0
  audited

  has_one_attached :photo
  has_many :bike_rental_details, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :photo, presence: true

  before_save -> { resize_image :photo, 856, nil }

  scope :ordered, -> { order :position }

  accepts_nested_attributes_for :bike_rental_details, allow_destroy: true
end
