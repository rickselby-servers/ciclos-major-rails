# frozen_string_literal: true

class SeasonsController < ApplicationController
  include Cropper

  before_action :authenticate_admin!
  before_action :set_season, only: %i[show edit update destroy]
  before_action :process_photo, only: %i[create update]

  def index
    @seasons = Season.all.reversed
  end

  def show; end

  def new
    @season = Season.new
  end

  def edit; end

  def create
    @season = Season.new(season_params)

    if @season.save
      redirect_to season_path(@season), notice: t(".success")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @season.update(season_params)
      redirect_to season_path(@season), notice: t(".success"), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @season.destroy!

    redirect_to seasons_path, notice: t(".success"), status: :see_other
  end

  private

  def process_photo
    process_image params[:season][:photo], params[:season][:photo_crop_data]
  end

  def set_season
    @season = Season.find params[:id]
  end

  def season_params
    params.require(:season)
          .permit(:name, :description, :photo, :launch_date, :start_date, :end_date, :sold_out)
  end
end
