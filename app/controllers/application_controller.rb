# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :load_partners

  private

  def load_partners
    @partners = Partner.ordered
  end

  def turbo_only
    head :bad_request unless turbo_frame_request?
  end
end
