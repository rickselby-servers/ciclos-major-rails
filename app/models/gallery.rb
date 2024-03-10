# frozen_string_literal: true

class Gallery < ApplicationRecord
  audited

  validates :name, presence: true
  validates :date, presence: true

  scope :ordered, -> { order date: :desc }
end
