# frozen_string_literal: true

# Handle retrieval and caching of page text
class PageTextService
  include Singleton

  class << self
    delegate :get_text, to: :instance
    delegate :set_text, to: :instance
  end

  def get_text(key, default = key)
    all_text[key] || default
  end

  def set_text(key, text)
    if all_text.key? key
      PageText.where(key:).update(text:).save
    else
      PageText.create key:, text:
    end
    clear_cache
  end

  private

  def clear_cache
    @text = nil
  end

  def all_text
    @all_text ||= PageText.all.to_h { |page_text| [page_text.key, page_text.text] }
  end
end