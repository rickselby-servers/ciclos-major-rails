# frozen_string_literal: true

class TestimonialsController < ApplicationController
  include Moveable

  before_action :authenticate_admin!, except: :index
  before_action :set_testimonial, only: %i[edit update destroy move]

  def index
    @testimonials = Testimonial.ordered
  end

  def new
    @testimonial = Testimonial.new
  end

  def edit; end

  def create
    @testimonial = Testimonial.new(testimonial_params)

    if @testimonial.save
      redirect_to testimonials_path, notice: t(".success")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @testimonial.update(testimonial_params)
      redirect_to testimonials_path, notice: t(".success"), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @testimonial.destroy!

    redirect_to testimonials_path, notice: t(".success"), status: :see_other
  end

  def move
    super(@testimonial)
  end

  private

  def set_testimonial
    @testimonial = Testimonial.find params[:id]
  end

  def testimonial_params
    params.require(:testimonial).permit(:title, :text)
  end
end
