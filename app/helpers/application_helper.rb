# frozen_string_literal: true

# General application-level helpers
module ApplicationHelper
  def fa_icon(name, fa_style = "fa-solid", **html_options)
    classes = [fa_style, "fa-#{name}"]
    classes << "fa-fw" unless html_options.key? :no_fw
    classes += Array(html_options[:class]) if html_options.key? :class
    html_options[:class] = classes.join " "

    content_tag :span, nil, html_options
  end
end
