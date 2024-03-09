# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/galleries" do
  let(:gallery) { create :gallery }

  describe "GET /index" do
    subject do
      get galleries_path
      response
    end

    it { is_expected.to be_successful }
  end

  describe "GET /show" do
    subject do
      get gallery_path(gallery)
      response
    end

    it { is_expected.to be_successful }
  end

  describe "GET /new" do
    subject do
      get new_gallery_path
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it { is_expected.to be_successful }
    end
  end

  describe "GET /edit" do
    subject do
      get edit_gallery_path(gallery)
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it { is_expected.to be_successful }
    end
  end

  describe "POST /create" do
    subject(:do_post) do
      post galleries_path, params: { gallery: attributes_for(:gallery) }
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      context "with valid parameters" do
        it "creates a new Gallery" do
          expect { do_post }.to change(Gallery, :count).by(1)
        end

        it { is_expected.to redirect_to galleries_path }
      end

      context "with invalid parameters" do
        subject(:do_post) do
          post galleries_path, params: { gallery: attributes_for(:gallery, :invalid) }
          response
        end

        it "does not create a new Gallery" do
          expect { do_post }.not_to change(Gallery, :count)
        end

        it { is_expected.to have_http_status :unprocessable_entity }
      end
    end
  end

  describe "PATCH /update" do
    subject(:do_patch) do
      patch gallery_path(gallery), params: { gallery: new_attributes }
      response
    end

    let(:new_attributes) { attributes_for :gallery }

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      context "with valid parameters" do
        let(:expected_attributes) { new_attributes.except(:photos).transform_keys(&:to_s) }

        it "updates the requested gallery" do
          do_patch
          expect(gallery.reload.attributes.slice(*expected_attributes.keys)).to eq expected_attributes
        end

        it { is_expected.to redirect_to galleries_path }
      end

      context "with invalid parameters" do
        subject(:do_patch) do
          patch gallery_path(gallery), params: { gallery: attributes_for(:gallery, :invalid) }
          response
        end

        let(:expected_attributes) { gallery.attributes.transform_keys(&:to_s) }

        it "does not update the requested gallery" do
          do_patch
          expect(gallery.reload.attributes.slice(*expected_attributes.keys)).to eq expected_attributes
        end

        it { is_expected.to have_http_status :unprocessable_entity }
      end
    end
  end

  describe "DELETE /destroy" do
    subject(:do_delete) do
      delete gallery_path(gallery)
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it "destroys the requested gallery" do
        gallery # load the gallery before the check that we delete it
        expect { do_delete }.to change(Gallery, :count).by(-1)
      end

      it { is_expected.to redirect_to galleries_path }
    end
  end
end
