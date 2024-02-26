# frozen_string_literal: true

class PageText < ApplicationRecord
  audited

  validates :key, presence: true, uniqueness: true
end
