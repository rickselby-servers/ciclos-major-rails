# frozen_string_literal: true

class GuidesController < ApplicationController
  before_action :authenticate_admin!, except: :index
  before_action :set_guide, only: %i[edit update destroy]
  before_action :process_photo, only: %i[create update]

  def index
    @guides = Guide.ordered
  end

  def new
    @guide = Guide.new
  end

  def edit; end

  def create
    @guide = Guide.new(guide_params)

    if @guide.save
      redirect_to guides_path, notice: t(".success")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @guide.update(guide_params)
      redirect_to guides_path, notice: t(".success")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @guide.destroy!

    redirect_to guides_path, notice: t(".success")
  end

  def move
    guide = Guide.find_by position: params[:from]
    guide.insert_at params[:to].to_i

    head :ok
  end

  private

  def process_photo
    return unless guide_params.key? :photo

    image = ImageProcessing::Vips.source(params[:guide][:photo].tempfile.path)

    crop_data = JSON.parse(params[:guide][:photo_crop_data]).fetch_values("x", "y", "width", "height").map(&:to_i)

    original_image = Vips::Image.new_from_file(params[:guide][:photo].tempfile.path)
    width = original_image.width
    height = original_image.height

    if crop_data[0].negative? || crop_data[1].negative?
      width -= [0, crop_data[0]].min
      height -= [0, crop_data[1]].min

      image = image.resize_and_pad(width, height, gravity: "south-east")
      crop_data[0] = [0, crop_data[0]].max
      crop_data[1] = [0, crop_data[1]].max
    end

    if crop_data[2] > width || crop_data[3] > height
      width = [width, crop_data[2]].max
      height = [height, crop_data[3]].max

      image = image.resize_and_pad(width, height, gravity: "north-west")
    end

    params[:guide][:photo].tempfile = image.crop!(*crop_data)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_guide
    @guide = Guide.find params[:id]
  end

  # Only allow a list of trusted parameters through.
  def guide_params
    params.require(:guide).permit(:name, :description, :photo)
  end
end
