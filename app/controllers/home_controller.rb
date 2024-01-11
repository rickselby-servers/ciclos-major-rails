# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_admin!, except: :show

  def show; end

  def edit; end

  def update; end
end
