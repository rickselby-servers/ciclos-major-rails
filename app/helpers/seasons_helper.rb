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

    content_tag :div, text, class: [:badge, :"text-bg-#{klass}"]
  end
end
