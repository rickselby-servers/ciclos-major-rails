# frozen_string_literal: true

class Carousel < ApplicationRecord
  audited

  has_many :photos, as: :photoable, dependent: :destroy

  validates :reference, presence: true

  scope :ordered, -> { order reference: :desc }

  def name
    reference.underscore.humanize.titleize
  end
end
