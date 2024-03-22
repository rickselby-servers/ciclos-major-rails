# frozen_string_literal: true

class PhotosController < ApplicationController
  include Cropper

  before_action :authenticate_admin!
  before_action :set_photo, only: %i[edit update destroy]
  before_action :set_target, only: %i[new create]

  def new
    @photo = Photo.new photoable: @target
  end

  def edit; end

  def create
    add_photos

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("photo-list", partial: "list", locals: { photos: @target.photos })
      end
      format.html { redirect_to polymorphic_path(@target), notice: t(".success") }
    end
  end

  def update
    if @photo.update(edit_photo_params)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(helpers.dom_id(@photo), partial: "photo", locals: { photo: @photo })
        end
        format.html { redirect_to polymorphic_path(@photo.photoable), notice: t(".success"), status: :see_other }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @photo.destroy!

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(helpers.dom_id(@photo)) }
      format.html { redirect_to polymorphic_path(@photo.photoable), notice: t(".success"), status: :see_other }
    end
  end

  private

  def set_target
    @target = GlobalID::Locator.locate params[:target]
    head :unprocessable_entity unless @target
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def edit_photo_params
    params.require(:photo).permit(:alt)
  end

  def add_photos
    params[:photo][:photos].each { |photo| Photo.create photoable: @target, photo: }
  end
end
