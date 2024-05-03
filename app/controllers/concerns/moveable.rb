# frozen_string_literal: true

module Moveable
  extend ActiveSupport::Concern

  def move(model)
    model.insert_at params[:to].to_i

    head :ok
  end
end
