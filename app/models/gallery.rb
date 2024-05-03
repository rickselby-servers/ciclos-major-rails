# frozen_string_literal: true

class Gallery < ApplicationRecord
  audited

  PHOTO_WIDTH = 400
  PHOTO_HEIGHT = nil

  has_many :photos, as: :photoable, dependent: :destroy

  validates :name, presence: true
  validates :date, presence: true

  scope :ordered, -> { order date: :desc }

  def index_photo
    photos.ordered.first
  end
end
