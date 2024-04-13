# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/photos" do
  let(:gallery) { create :gallery }
  let(:photo) { create :photo, photoable: gallery }

  describe "GET /new" do
    subject do
      get new_photo_path(target: gallery.to_global_id)
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      context "with a target" do
        it { is_expected.to be_successful }
      end

      context "without a target" do
        subject do
          get new_photo_path
          response
        end

        it { is_expected.to have_http_status :unprocessable_entity }
      end
    end
  end

  describe "GET /edit" do
    subject do
      get edit_photo_url(photo)
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it { is_expected.to be_successful }
    end
  end

  describe "POST /create" do
    subject(:do_post) do
      post photos_path, params: { photo: { photos: [photo] }, target: gallery.to_global_id }
      response
    end

    let(:photo) { attributes_for(:photo)[:photo] }

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      context "with valid parameters" do
        it "creates a new Photo" do
          expect { do_post }.to change(Photo, :count).by(1)
        end

        it { is_expected.to redirect_to gallery_path(gallery) }
      end

      context "without a target" do
        subject(:do_post) do
          post photos_path, params: { photo: { photos: [photo] } }
          response
        end

        it "does not create a new Photo" do
          expect { do_post }.not_to change(Photo, :count)
        end

        it { is_expected.to have_http_status :unprocessable_entity }
      end

      context "with no photos" do
        subject(:do_post) do
          post photos_path, params: { photo: { photos: [] }, target: gallery.to_global_id }
          response
        end

        it "does not create a new Photo" do
          expect { do_post }.not_to change(Photo, :count)
        end

        it { is_expected.to redirect_to gallery_path(gallery) }
      end
    end
  end

  describe "PATCH /update" do
    subject(:do_patch) do
      patch photo_url(photo), params: { photo: new_attributes }
      response
    end

    let(:new_attributes) { attributes_for :photo }

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      context "with valid parameters" do
        let(:expected_attributes) { new_attributes.except(:photo).transform_keys(&:to_s) }

        it "updates the requested photo" do
          do_patch
          expect(photo.reload.attributes.slice(*expected_attributes.keys)).to eq expected_attributes
        end

        it { is_expected.to redirect_to gallery_path(gallery) }
      end
    end
  end

  describe "DELETE /destroy" do
    subject(:do_delete) do
      delete photo_url(photo)
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it "destroys the requested photo" do
        photo # load the photo before the check that we delete it
        expect { do_delete }.to change(Photo, :count).by(-1)
      end

      it { is_expected.to redirect_to gallery_path(gallery) }
    end
  end
end
