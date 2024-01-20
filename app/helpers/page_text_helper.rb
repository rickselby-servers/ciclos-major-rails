# frozen_string_literal: true

# Helpers around editable page text
module PageTextHelper
  def editable_text(key, classes: [])
    full_key = "#{@virtual_path.gsub(%r{/_?}, ".")}.#{key}" # rubocop:disable Rails/HelperInstanceVariable
    EditableTextHelper.new(self, full_key, classes:).html
  end
end
