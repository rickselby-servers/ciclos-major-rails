# frozen_string_literal: true

require "rails_helper"
require_relative "shared/resize_image"

RSpec.describe Gallery do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :date }

  it { is_expected.to be_audited }
  it { is_expected.to have_many :photos }

  it_behaves_like "it resizes a photo correctly",
                  { "400x400" => [400, 400], "400x800" => [400, 800], "800x400" => [400, 200] }
end
