# frozen_string_literal: true

class PageTextController < ApplicationController
  before_action :authenticate_admin!

  def update
    page_text = PageText.find params[:id]
    PageTextService.set_text page_text, params[page_text.key]
    redirect_back fallback_location: root_path
  end
end
