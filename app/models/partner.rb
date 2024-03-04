# frozen_string_literal: true

class Partner < ApplicationRecord
  acts_as_list top_of_list: 0
  audited

  has_one_attached :logo

  validates :name, presence: true
  validates :details, presence: true
  validates :url, presence: true
  validates :logo, presence: true

  before_save :resize_photo

  scope :ordered, -> { order :position }

  LOGO_MAX_WIDTH = 200
  LOGO_MAX_HEIGHT = 200

  private

  def resize_photo
    return unless can_resize_photo?

    attachable = attachment_changes[:logo.to_s].attachable
    tempfile = ImageProcessing::Vips.source(attachable.tempfile.path).resize_to_limit!(LOGO_MAX_WIDTH, LOGO_MAX_HEIGHT)

    self.logo = if attachable.is_a? Rack::Test::UploadedFile
                  Rack::Test::UploadedFile.new tempfile.path
                else
                  attachable.tempfile = tempfile
                  attachable
                end
  end

  def can_resize_photo?
    logo.attached? && attachment_changes.key?(:logo.to_s) &&
      attachment_changes[:logo.to_s].is_a?(ActiveStorage::Attached::Changes::CreateOne)
  end
end
