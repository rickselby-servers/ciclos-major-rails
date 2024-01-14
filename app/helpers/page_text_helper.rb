# frozen_string_literal: true

# Helpers around editable page text
module PageTextHelper
  def editable_text(key, classes: [])
    EditableTextHelper.new(self, key, classes:).html
  end
end
