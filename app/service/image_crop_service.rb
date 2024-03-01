# frozen_string_literal: true

# Crop an image as per data from cropper
class ImageCropService
  def initialize(image_path)
    @image_path = image_path
  end

  def crop(x:, y:, width:, height:, rotate:)
    image = ImageProcessing::Vips.source(@image_path)
    image = image.rotate(rotate) unless rotate.zero?
    image.crop!(x, y, width, height)
  end
end
