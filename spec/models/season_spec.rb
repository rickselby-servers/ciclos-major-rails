# frozen_string_literal: true

require "rails_helper"
require_relative "shared/resize_image"

RSpec.describe Season do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to validate_presence_of :photo }
  it { is_expected.to validate_presence_of :start_date }
  it { is_expected.to validate_presence_of :end_date }
  it { is_expected.to validate_presence_of :launch_date }

  context "with values for comparison" do
    subject { create :season }

    it { is_expected.to validate_comparison_of(:start_date).is_greater_than_or_equal_to(:launch_date) }
    it { is_expected.to validate_comparison_of(:end_date).is_greater_than_or_equal_to(:start_date) }
  end

  it { is_expected.to be_audited }
  it { is_expected.to have_one_attached :photo }

  it_behaves_like "it resizes an image correctly",
                  :photo,
                  { "400x400" => [400, 400], "1000x2000" => [207, 413], "2000x1000" => [550, 275] }
end
