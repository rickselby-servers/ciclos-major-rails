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
    @signed_in ? form : div_tag
  end

  private

  attr_reader :context

  def form
    context.bootstrap_form_with model: page_text, data: { controller: :tinymce } do |form|
      div_tag + submit_button(form)
    end
  end

  def div_tag
    context.tag.div class: @classes, id: @key, data: div_data do
      context.sanitize PageTextService.get_text(@key)
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

  def div_data
    return {} unless @signed_in

    { tinymce_target: :input }
  end
end
