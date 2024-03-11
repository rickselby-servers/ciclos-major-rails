# frozen_string_literal: true

class Photo < ApplicationRecord
  include ResizeImage

  acts_as_list scope: :photoable
  audited

  belongs_to :photoable, polymorphic: true
  has_one_attached :photo

  validates :photo, presence: true

  scope :ordered, -> { order :position }
end
