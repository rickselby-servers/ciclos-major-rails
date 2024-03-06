# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :load_partners
  before_action :turbo_frame_request_variant

  private

  def load_partners
    @partners = Partner.ordered
  end

  def turbo_frame_request_variant
    request.variant = :turbo_frame if turbo_frame_request?
  end
end
