# frozen_string_literal: true

class PhotosController < ApplicationController
  include Cropper

  before_action :authenticate_admin!
  before_action :set_photo, only: %i[edit update destroy]

  def new
    @photo = Photo.new
  end

  def edit; end

  def create
    @photo = Photo.new(photo_params)

    if @photo.save
      redirect_to photos_path, notice: t(".success")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @photo.update(photo_params)
      redirect_to photos_path, notice: t(".success"), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @photo.destroy!

    redirect_to photos_path, notice: t(".success"), status: :see_other
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:photoable_id, :photoable_type, :position, :alt, :photo)
  end
end
