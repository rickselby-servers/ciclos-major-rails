# frozen_string_literal: true

class Testimonial < ApplicationRecord
  acts_as_list top_of_list: 0, add_new_at: :top
  audited

  validates :title, presence: true
  validates :text, presence: true

  scope :ordered, -> { order :position }
end
