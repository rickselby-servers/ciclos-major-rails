# frozen_string_literal: true

class PartnersController < ApplicationController
  include Cropper
  include Moveable

  before_action :authenticate_admin!, except: :show
  before_action :set_partner, only: %i[show edit update destroy move]
  before_action :process_photo, only: %i[create update]

  def index
    @partners = Partner.ordered
  end

  def show; end

  def new
    @partner = Partner.new
  end

  def edit; end

  def create
    @partner = Partner.new partner_params

    if @partner.save
      redirect_to partners_path, notice: t(".success")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @partner.update partner_params
      redirect_to partners_path, notice: t(".success"), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @partner.destroy!

    redirect_to partners_path, notice: t(".success"), status: :see_other
  end

  def move
    super(@partner)
  end

  private

  def process_photo
    process_image params[:partner][:logo], params[:partner][:logo_crop_data]
  end

  def set_partner
    @partner = Partner.find params[:id]
  end

  def partner_params
    params.expect(partner: %i[name details url logo])
  end
end
