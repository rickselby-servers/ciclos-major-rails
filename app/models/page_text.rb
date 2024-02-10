# frozen_string_literal: true

class PageText < ApplicationRecord
  validates :key, presence: true, uniqueness: true

  audited
end
