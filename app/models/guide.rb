# frozen_string_literal: true

class Guide < ApplicationRecord
  acts_as_list top_of_list: 0
  audited

  has_one_attached :photo

  validates :name, presence: true
  validates :description, presence: true
  validates :photo, presence: true

  before_save :resize_photo

  scope :ordered, -> { order :position }

  PHOTO_MAX_WIDTH = 200

  private

  def resize_photo
    return unless can_resize_photo?

    attachable = attachment_changes[:photo.to_s].attachable
    attachable.tempfile = ImageProcessing::Vips.source(attachable.tempfile.path).resize_to_limit!(PHOTO_MAX_WIDTH, nil)
    self.photo = attachable
  end

  def can_resize_photo?
    photo.attached? && attachment_changes.key?(:photo.to_s) &&
      attachment_changes[:photo.to_s].is_a?(ActiveStorage::Attached::Changes::CreateOne)
  end
end
