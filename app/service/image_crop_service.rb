# frozen_string_literal: true

# Crop an image as per data from cropper
class ImageCropService
  def initialize(image_path)
    @image_path = image_path
  end

  def crop(x:, y:, width:, height:)
    @crop_data = { x:, y:, width:, height: }
    @image = ImageProcessing::Vips.source(@image_path)
    @width = image_source.width
    @height = image_source.height

    handle_negative_crop if negative_crop?
    handle_oversized_crop if oversized_crop?

    @image.crop! *@crop_data.fetch_values(:x, :y, :width, :height)
  end

  private

  def image_source
    @image_source ||= Vips::Image.new_from_file(@image_path)
  end

  def negative_crop?
    @crop_data[:x].negative? || @crop_data[:y].negative?
  end

  def handle_negative_crop
    @width -= [0, @crop_data[:x]].min
    @height -= [0, @crop_data[:y]].min

    @image = @image.resize_and_pad(@width, @height, gravity: "south-east")
    sort_negative_width
    sort_negative_height
  end

  def sort_negative_width
    return unless @crop_data[:x].negative?

    @crop_data[:width] -= @crop_data[:x]
    @crop_data[:x] = 0
  end

  def sort_negative_height
    return unless @crop_data[:y].negative?

    @crop_data[:height] -= @crop_data[:y]
    @crop_data[:y] = 0
  end

  def oversized_crop?
    @crop_data[:width] > @width || @crop_data[:height] > @height
  end

  def handle_oversized_crop
    @width = [@width, @crop_data[:width]].max
    @height = [@height, @crop_data[:height]].max

    @image = @image.resize_and_pad(@width, @width, gravity: "north-west")
  end
end
