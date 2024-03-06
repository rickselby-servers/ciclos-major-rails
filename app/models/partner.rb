# frozen_string_literal: true

class Partner < ApplicationRecord
  include ResizeImage

  acts_as_list top_of_list: 0
  audited

  has_one_attached :logo

  validates :name, presence: true
  validates :details, presence: true
  validates :url, presence: true
  validates :logo, presence: true

  before_save -> { resize_image :logo, 200, 200 }

  scope :ordered, -> { order :position }
end
