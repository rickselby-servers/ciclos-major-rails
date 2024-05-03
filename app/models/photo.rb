# frozen_string_literal: true

class Photo < ApplicationRecord
  include ResizeImage

  acts_as_list scope: %i[photoable_type photoable_id], top_of_list: 0
  audited

  belongs_to :photoable, polymorphic: true
  has_one_attached :photo

  validates :photo, presence: true

  scope :ordered, -> { order :position }
end
