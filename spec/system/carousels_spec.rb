# frozen_string_literal: true

require "rails_helper"
require_relative "shared/photo_list"

RSpec.describe "Carousels", :logged_in do
  include ActionView::RecordIdentifier

  context "with an existing carousel" do
    let!(:carousel) { create :carousel }

    it_behaves_like "it handles a list of photos" do
      let(:model) { carousel }
      let(:path) { carousel_path carousel }
    end
  end
end
