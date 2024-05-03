# frozen_string_literal: true

require "vips"

RSpec.shared_examples "it resizes an image correctly" do |key, sizes|
  let(:model) { create described_class.model_name.i18n_key, key => image }
  let(:image_path) { ActiveStorage::Blob.service.path_for model.public_send(key).key }
  let(:vips_image) { Vips::Image.new_from_file image_path }

  let(:image) { Rack::Test::UploadedFile.new "spec/fixtures/files/#{basename}.jpg", "image/jpg" }

  sizes.each do |file_basename, size|
    context "with the file #{file_basename}" do
      let(:basename) { file_basename }

      example { expect(vips_image.width).to eq size[0] }
      example { expect(vips_image.height).to eq size[1] }
    end
  end
end

RSpec.shared_examples "it resizes a photo correctly" do |sizes|
  let(:model) { create described_class.model_name.i18n_key }
  let(:photo) { model.photos.create photo: image }
  let(:image_path) { ActiveStorage::Blob.service.path_for photo.photo.key }
  let(:vips_image) { Vips::Image.new_from_file image_path }

  let(:image) { Rack::Test::UploadedFile.new "spec/fixtures/files/#{basename}.jpg", "image/jpg" }

  sizes.each do |file_basename, size|
    context "with the file #{file_basename}" do
      let(:basename) { file_basename }

      example { expect(vips_image.width).to eq size[0] }
      example { expect(vips_image.height).to eq size[1] }
    end
  end
end
