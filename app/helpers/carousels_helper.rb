# frozen_string_literal: true

# Helpers for showing carousels
module CarouselsHelper
  def carousel(reference)
    carousel = Carousel.find_by(reference:)
    carousel ||= Carousel.create(reference:)

    render partial: "carousels/carousel", locals: { carousel: }
  end
end
