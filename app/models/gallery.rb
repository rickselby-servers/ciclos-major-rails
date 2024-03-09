# frozen_string_literal: true

class Gallery < ApplicationRecord
  has_many_attached :photos

  audited

  validates :name, presence: true
  validates :date, presence: true

  scope :ordered, -> { order date: :desc }
end
