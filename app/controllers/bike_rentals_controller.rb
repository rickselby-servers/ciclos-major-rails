# frozen_string_literal: true

class BikeRentalsController < ApplicationController
  include Cropper
  include Moveable

  before_action :authenticate_admin!, except: :index
  before_action :set_bike_rental, only: %i[edit update destroy move]
  before_action :process_photo, only: %i[create update]

  def index
    @bike_rentals = BikeRental.ordered
  end

  def new
    @bike_rental = BikeRental.new
  end

  def edit; end

  def create
    @bike_rental = BikeRental.new(bike_rental_params)

    if @bike_rental.save
      redirect_to bike_rentals_path, notice: t(".success")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @bike_rental.update(bike_rental_params)
      redirect_to bike_rentals_path, notice: t(".success"), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bike_rental.destroy!

    redirect_to bike_rentals_path, notice: t(".success"), status: :see_other
  end

  def move
    super(@bike_rental)
  end

  private

  def process_photo
    process_image params[:bike_rental][:photo], params[:bike_rental][:photo_crop_data]
  end

  def set_bike_rental
    @bike_rental = BikeRental.find params[:id]
  end

  def bike_rental_params # rubocop:disable Metrics/MethodLength
    params.expect(
      bike_rental: [
        :name,
        :description,
        :photo,
        {
          bike_rental_details_attributes: %i[id _destroy key value],
          bike_rental_prices_attributes:  %i[id _destroy days total_price],
        },
      ],
    )
  end
end
