# frozen_string_literal: true

{
  en: {
    date: {
      formats: {
        words:         ->(date) { "#{date.day.ordinalize} %B %Y" },
        words_no_year: ->(date) { "#{date.day.ordinalize} %B" },
      },
    },
  },
}
