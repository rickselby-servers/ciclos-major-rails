# frozen_string_literal: true

class Season < ApplicationRecord
  extend FriendlyId
  include ResizeImage

  audited

  has_one_attached :photo

  friendly_id :name, use: %i[slugged history]

  validates :name, presence: true
  validates :description, presence: true
  validates :photo, presence: true
  validates :launch_date, presence: true
  validates :start_date, presence: true, comparison: { greater_than_or_equal_to: :launch_date }
  validates :end_date, presence: true, comparison: { greater_than_or_equal_to: :start_date }

  before_save -> { resize_image :photo, 550, 413 }

  scope :ordered, -> { order :start_date }
  scope :reversed, -> { order start_date: :desc }
  scope :visible, -> { where "launch_date <= NOW()::date and end_date >= NOW()::date" }

  def launched?
    launch_date.past? || launch_date.today?
  end

  def started?
    start_date.past? || start_date.today?
  end

  def finished?
    end_date.past? || end_date.today?
  end

  def visible?
    launched? && !finished?
  end

  def should_generate_new_friendly_id?
    name_changed? || super
  end
end
