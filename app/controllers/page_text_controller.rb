# frozen_string_literal: true

class PageTextController < ApplicationController
  before_action :authenticate_admin!

  def update
    PageTextService.set_text params[:id], params[params[:id]]
  end
end
