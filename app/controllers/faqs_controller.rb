# frozen_string_literal: true

class FaqsController < ApplicationController
  before_action :authenticate_admin!, except: :index
  before_action :set_faq, only: %i[edit update destroy]

  def index
    @faqs = Faq.ordered
  end

  def new
    @faq = Faq.new
  end

  def edit; end

  def create
    @faq = Faq.new(faq_params)

    if @faq.save
      redirect_to faqs_path, notice: t(".success")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @faq.update(faq_params)
      redirect_to faqs_path, notice: t(".success")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @faq.destroy!

    redirect_to faqs_path, notice: t(".success")
  end

  def move_position
    faq = Faq.find_by(position: params[:old_position])
    faq.insert_at params[:new_position].to_i

    head :ok
  end

  private

  def set_faq
    @faq = Faq.find(params[:id])
  end

  def faq_params
    params.require(:faq).permit(:question, :answer)
  end
end
