# frozen_string_literal: true

# Helpers around editable page text
module PageTextHelper
  def editable_text(key, classes: [])
    full_key = @virtual_path.split("/").push(key).join(".") # rubocop:disable Rails/HelperInstanceVariable

    # TODO: use page text service so we don't hit the DB every time
    page_text = PageText.find_or_create_by(key: full_key)

    p_tag = editable_text_p page_text, classes
    return p_tag unless admin_signed_in?

    bootstrap_form_with model: page_text do |form|
      p_tag + form.submit
    end
  end

  def editable_text_p(page_text, classes)
    tag.p class: (tinymce_classes + classes).uniq, id: page_text.id do
      page_text.text
    end
  end

  def tinymce_classes
    return [] unless admin_signed_in?

    %w[tinymce-body]
  end
end
