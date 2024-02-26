# frozen_string_literal: true

class Guide < ApplicationRecord
  acts_as_list top_of_list: 0
  audited

  has_one_attached :photo

  validates :name, presence: true
  validates :description, presence: true
  validates :photo, presence: true

  scope :ordered, -> { order :position }
end
