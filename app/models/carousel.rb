# frozen_string_literal: true

class Carousel < ApplicationRecord
  audited

  PHOTO_WIDTH = nil
  PHOTO_HEIGHT = 400

  has_many :photos, as: :photoable, dependent: :destroy

  validates :reference, presence: true

  scope :ordered, -> { order reference: :asc }

  def name
    reference.humanize.titleize
  end
end
