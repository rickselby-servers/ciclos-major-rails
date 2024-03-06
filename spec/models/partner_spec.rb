# frozen_string_literal: true

require "rails_helper"
require_relative "shared/resize_image"

RSpec.describe Partner do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :details }
  it { is_expected.to validate_presence_of :url }
  it { is_expected.to validate_presence_of :logo }

  it { is_expected.to be_audited }
  it { is_expected.to have_one_attached :logo }

  it_behaves_like "it resizes an image correctly",
                  :logo,
                  { "400x400" => [200, 200], "400x800" => [100, 200], "800x400" => [200, 100] }
end
