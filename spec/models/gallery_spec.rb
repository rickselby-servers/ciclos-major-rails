# frozen_string_literal: true

require "rails_helper"

RSpec.describe Gallery do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :date }

  it { is_expected.to be_audited }

  # TODO: tests for adding a single photo...
  # it_behaves_like "it resizes an image correctly",
  #                 :photo,
  #                 { "400x400" => [400, 400], "400x800" => [210, 420], "800x400" => [400, 400] }
end
