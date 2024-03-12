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
    @photo = Photo.new(photo_params)

    if @photo.save
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.append("photos", **photo_partial) }
        format.html { redirect_to polymorphic_path(@photo.photoable), notice: t(".success") }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @photo.update(photo_params)
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace(helpers.dom_id(@photo), **photo_partial) }
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

  def photo_partial
    {
      partial: "#{@photo.photoable.model_name.route_key}/photo",
      locals:  { photo: @photo },
    }
  end

  def set_target
    @target = GlobalID::Locator.locate params[:target]
    head :unprocessable_entity unless @target
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:photoable_id, :photoable_type, :position, :alt, :photo)
  end
end
