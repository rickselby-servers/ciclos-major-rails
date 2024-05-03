# frozen_string_literal: true

class CarouselsController < ApplicationController
  before_action :set_carousel, only: %i[show]

  before_action :authenticate_admin!

  def index
    @carousels = Carousel.ordered
  end

  def show; end

  private

  def set_carousel
    @carousel = Carousel.find(params[:id])
  end
end
