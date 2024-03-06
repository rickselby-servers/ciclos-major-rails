# frozen_string_literal: true

# Helpers for partners
module PartnerHelper
  def partner_modal_classes(inline)
    %w[modal partner-modal] + (inline ? %w[show position-static d-block] : %w[fade])
  end

  def partner_modal_data(inline)
    inline ? {} : { controller: :modal }
  end
end
