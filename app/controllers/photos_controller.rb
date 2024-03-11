# frozen_string_literal: true

class PhotosController < ApplicationController
  include Cropper

  before_action :authenticate_admin!
  before_action :set_photo, only: %i[edit update destroy]
  before_action :set_target, only: :new

  def new
    @photo = Photo.new photoable: @target
  end

  def edit; end

  def create
    params[:photo][:photos].each { |photo| Photo.create create_photo_params.merge(photo:) }
    temp_photo = Photo.new create_photo_params

    redirect_to polymorphic_path(temp_photo.photoable), notice: t(".success")
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

  def set_target
    @target = GlobalID::Locator.locate params[:target]
    head :unprocessable_entity unless @target
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def create_photo_params
    params.require(:photo).permit(:photoable_id, :photoable_type)
  end

  def edit_photo_params
    params.require(:photo).permit(:alt)
  end
end
