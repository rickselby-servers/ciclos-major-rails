# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cropper, ".process_image", type: :controller do
  controller ApplicationController do
    include Cropper # rubocop:disable RSpec/DescribedClass
  end

  subject(:call_process_image) { controller.process_image(image_param, crop_data_json) }

  before do
    allow(ImageCropService).to receive(:new).with(path).and_return(image_crop_service)
    allow(image_crop_service).to receive(:crop).and_return(returned_image)
    allow(image_param).to receive(:"tempfile=") unless image_param.nil?
  end

  let(:crop_data) { { x: 1, y: 1, width: 170, height: 176, rotate: 0 } }
  let(:crop_data_json) { crop_data.to_json }
  let(:image_crop_service) { instance_double ImageCropService }
  let(:image_param) { instance_double ActionDispatch::Http::UploadedFile, tempfile: }
  let(:path) { :foo }
  let(:returned_image) { instance_double Tempfile }
  let(:tempfile) { instance_double Tempfile, path: }

  context "with no image" do
    let(:image_param) { nil }

    it { is_expected.to be_nil }
  end

  context "with no crop data" do
    let(:crop_data_json) { nil }

    it { is_expected.to be_nil }
  end

  context "with empty crop data" do
    let(:crop_data) { {} }

    it { is_expected.to be_nil }
  end

  context "with an image and data" do
    it "passes data on to ImageCropService" do
      call_process_image
      expect(image_crop_service).to have_received(:crop).with(crop_data)
    end

    it "updates the tempfile" do
      call_process_image
      expect(image_param).to have_received(:"tempfile=").with(returned_image)
    end
  end
end
