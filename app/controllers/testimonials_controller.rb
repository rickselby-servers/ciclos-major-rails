# frozen_string_literal: true

class TestimonialsController < ApplicationController
  before_action :authenticate_admin!, except: :index
  before_action :set_testimonial, only: %i[edit update destroy]

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
      redirect_to testimonials_path, notice: t(".success")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @testimonial.destroy!

    redirect_to testimonials_path, notice: t(".success")
  end

  def move
    testimonial = Testimonial.find_by position: params[:from]
    testimonial.insert_at params[:to].to_i

    head :ok
  end

  private

  def set_testimonial
    @testimonial = Testimonial.find params[:id]
  end

  def testimonial_params
    params.require(:testimonial).permit(:title, :text)
  end
end
