# frozen_string_literal: true

require "rails_helper"
require_relative "shared/resize_image"

RSpec.describe Guide do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to validate_presence_of :photo }

  it { is_expected.to be_audited }
  it { is_expected.to have_one_attached :photo }

  it_behaves_like "it resizes an image correctly",
                  :photo,
                  { "400x400" => [200, 200], "400x800" => [200, 400], "800x400" => [200, 100] }
end
