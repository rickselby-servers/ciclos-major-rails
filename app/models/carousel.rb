# frozen_string_literal: true

class Carousel < ApplicationRecord
  audited

  has_many :photos, as: :photoable, dependent: :destroy

  validates :reference, presence: true

  scope :ordered, -> { order reference: :desc }
end
