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

  def seasons_for_home_page
    @seasons_for_home_page ||= Season.visible.ordered.limit(4)
  end

  def home_page_season_row_classes
    %i[row g-4 text-center mb-3] + case seasons_for_home_page.size
                                   when 1, 2 then %i[row-cols-1 row-cols-sm-2 row-cols-lg-2]
                                   when 3 then %i[row-cols-1 row-cols-sm-3 row-cols-lg-3]
                                   when 4 then %i[row-cols-1 row-cols-sm-2 row-cols-lg-4]
                                   else []
                                   end
  end

  def home_page_season_col_classes(season = nil)
    return home_page_season_first_col_classes if season == seasons_for_home_page.first

    %i[col] + case seasons_for_home_page.size
              when 1 then %i[col-sm-6 col-lg-4]
              when 2 then %i[col-lg-4]
              else []
              end
  end

  def home_page_season_first_col_classes
    home_page_season_col_classes + case seasons_for_home_page.size
                                   when 1 then %i[offset-sm-3 offset-lg-4]
                                   when 2 then %i[offset-lg-2]
                                   else []
                                   end
  end
end
