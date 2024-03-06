# frozen_string_literal: true

module ResizeImage
  extend ActiveSupport::Concern

  private

  def resize_image(key, width, height)
    return unless can_resize_image?(key)

    attachable = attachment_changes[key.to_s].attachable
    tempfile = ImageProcessing::Vips.source(attachable.tempfile.path).resize_to_limit!(width, height)

    public_send :"#{key}=", if attachable.is_a? Rack::Test::UploadedFile
                              Rack::Test::UploadedFile.new tempfile.path
                            else
                              attachable.tempfile = tempfile
                              attachable
                            end
  end

  def can_resize_image?(key)
    public_send(key).attached? && attachment_changes.key?(key.to_s) &&
      attachment_changes[key.to_s].is_a?(ActiveStorage::Attached::Changes::CreateOne)
  end
end
