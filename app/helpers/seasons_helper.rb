# frozen_string_literal: true

# Helpers for seasons
module SeasonsHelper
  def season_status(season)
    klass, text = case season
                  when ->(s) { s.finished? } then [:light, I18n.t("seasons.finished")]
                  when ->(s) { s.started? } then [:success, I18n.t("seasons.active")]
                  when ->(s) { s.launched? } then [:primary, I18n.t("seasons.launched")]
                  else [:light, I18n.t("seasons.future")]
                  end

    date_status = content_tag :div, text, class: [:badge, :"text-bg-#{klass}"]
    return date_status unless season.sold_out?

    date_status + content_tag(:div, I18n.t("seasons.sold_out"), class: %i[badge text-bg-primary ms-1])
  end
end
