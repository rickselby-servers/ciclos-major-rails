# frozen_string_literal: true

require "rails_helper"
require "vips"

RSpec.describe ImageCropService, ".crop" do
  subject(:resized_image) { described_class.new(image_path).crop x:, y:, width:, height:, rotate: 0 }

  let(:height) { image.height }
  let(:image) { Vips::Image.new_from_file image_path }
  let(:image_path) { file_fixture("400x400.jpg").to_s }
  let(:width) { image.width }
  let(:x) { 0 }
  let(:y) { 0 }

  shared_examples "it resizes correctly" do
    let(:resized_image_vips) { Vips::Image.new_from_file resized_image.path }

    example { expect(resized_image_vips.width).to eq width }
    example { expect(resized_image_vips.height).to eq height }
  end

  context "with the same dimensions as the image" do
    it_behaves_like "it resizes correctly"
  end

  context "with smaller dimensions" do
    let(:x) { 10 }
    let(:y) { 10 }
    let(:width) { image.width - 20 }
    let(:height) { image.height - 20 }

    it_behaves_like "it resizes correctly"
  end
end
