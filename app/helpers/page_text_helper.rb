# frozen_string_literal: true

# Helpers around editable page text
module PageTextHelper
  def editable_text(key, classes: [])
    EditableTextHelper.new(self, page_text_key(key), classes:).html
  end

  def page_text_key(key)
    "#{@virtual_path.gsub(%r{/_?}, ".")}.#{key}" # rubocop:disable Rails/HelperInstanceVariable
  end
end
