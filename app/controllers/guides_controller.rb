# frozen_string_literal: true

class GuidesController < ApplicationController
  include Cropper

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
      redirect_to guides_path, notice: t(".success"), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @guide.destroy!

    redirect_to guides_path, notice: t(".success"), status: :see_other
  end

  def move
    guide = Guide.find_by position: params[:from]
    guide.insert_at params[:to].to_i

    head :ok
  end

  private

  def process_photo
    process_image params[:guide][:photo], params[:guide][:photo_crop_data]
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
