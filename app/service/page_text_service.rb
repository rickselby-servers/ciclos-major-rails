# frozen_string_literal: true

# Handle retrieval and caching of page text
class PageTextService
  include Singleton

  class << self
    delegate :get_text, to: :instance
    delegate :set_text, to: :instance
  end

  def get_text(key, default = key)
    all_text[key.to_s] || default
  end

  def set_text(page_text, text)
    page_text.update(text:)
    clear_cache
  end

  private

  def clear_cache
    @all_text = nil
  end

  def all_text
    @all_text ||= PageText.all.to_h { |page_text| [page_text.key, page_text.text] }
  end
end
