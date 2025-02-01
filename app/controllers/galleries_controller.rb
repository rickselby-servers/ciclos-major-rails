# frozen_string_literal: true

class GalleriesController < ApplicationController
  before_action :set_gallery, only: %i[show edit update destroy]

  before_action :authenticate_admin!, except: %i[index show]

  def index
    @galleries = Gallery.ordered
  end

  def show; end

  def new
    @gallery = Gallery.new
  end

  def edit; end

  def create
    @gallery = Gallery.new(gallery_params)

    if @gallery.save
      redirect_to gallery_path(@gallery), notice: t(".success")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @gallery.update(gallery_params)
      redirect_to gallery_path(@gallery), notice: t(".success"), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @gallery.destroy!

    redirect_to galleries_path, notice: t(".success"), status: :see_other
  end

  private

  def set_gallery
    @gallery = Gallery.find(params[:id])
  end

  def gallery_params
    params.expect(gallery: %i[name date])
  end
end
