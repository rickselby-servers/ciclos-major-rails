# frozen_string_literal: true

module Cropper
  extend ActiveSupport::Concern

  def process_image(image_param, crop_data_param)
    crop_data = JSON.parse(crop_data_param)
                    .slice("x", "y", "width", "height")
                    .symbolize_keys
                    .transform_values(&:to_i)

    image_param.tempfile = ImageCropService.new(image_param.tempfile.path).crop(**crop_data)
  end
end
