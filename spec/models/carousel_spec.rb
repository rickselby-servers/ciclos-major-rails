# frozen_string_literal: true

require "rails_helper"
require_relative "shared/resize_image"

RSpec.describe Carousel do
  it { is_expected.to validate_presence_of :reference }

  it { is_expected.to be_audited }
  it { is_expected.to have_many :photos }

  it_behaves_like "it resizes a photo correctly",
                  { "400x400" => [400, 400], "400x800" => [200, 400], "800x400" => [800, 400] }
end
