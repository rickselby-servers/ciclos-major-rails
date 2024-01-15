# frozen_string_literal: true

# Either return text to show or a form to edit text (if admin logged in)
class EditableTextHelper
  def initialize(context, key, classes: [])
    @context = context
    @key = key
    @classes = classes
    @signed_in = context.admin_signed_in?
  end

  def html
    @signed_in ? form : p_tag
  end

  private

  attr_reader :context

  def form
    context.bootstrap_form_with model: page_text do |form|
      p_tag + submit_button(form)
    end
  end

  def p_tag
    context.tag.p class: (tinymce_classes + @classes).uniq, id: page_text.id do
      page_text.text
    end
  end

  def page_text
    @page_text ||= PageText.find_or_create_by(key: @key)
  end

  def submit_button(form)
    context.tag.div class: %w[text-end] do
      form.submit extra_class: "mb-2", style: "display: none"
    end
  end

  def tinymce_classes
    return [] unless @signed_in

    %w[tinymce-body]
  end
end
