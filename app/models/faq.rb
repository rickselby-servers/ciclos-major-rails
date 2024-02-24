# frozen_string_literal: true

class Faq < ApplicationRecord
  acts_as_list top_of_list: 0
  audited

  validates :question, presence: true
  validates :answer, presence: true

  scope :ordered, -> { order :position }
end
