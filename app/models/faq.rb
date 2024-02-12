# frozen_string_literal: true

class Faq < ApplicationRecord
  validates :question, presence: true
  validates :answer, presence: true

  audited
end
