# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/guides" do
  let(:guide) { create :guide }

  describe "GET /index" do
    subject do
      get guides_path
      response
    end

    it { is_expected.to be_successful }
  end

  describe "GET /new" do
    subject do
      get new_guide_path
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it { is_expected.to be_successful }
    end
  end

  describe "GET /edit" do
    subject do
      get edit_guide_path guide
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it { is_expected.to be_successful }
    end
  end

  describe "POST /create" do
    subject(:do_post) do
      post guides_path, params: { guide: attributes_for(:guide) }
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      context "with valid parameters" do
        it "creates a new Guide" do
          expect { do_post }.to change(Guide, :count).by(1)
        end

        it { is_expected.to redirect_to guides_path }
      end

      context "with invalid parameters" do
        subject(:do_post) do
          post guides_path, params: { guide: attributes_for(:guide, :invalid) }
          response
        end

        it "does not create a new Guide" do
          expect { do_post }.not_to change(Guide, :count)
        end

        it { is_expected.to have_http_status :unprocessable_entity }
      end
    end
  end

  describe "PATCH /update" do
    subject(:do_patch) do
      patch guide_path(guide), params: { guide: new_attributes }
      response
    end

    let(:new_attributes) { attributes_for :guide }

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      context "with valid parameters" do
        let(:expected_attributes) { new_attributes.except(:photo).transform_keys(&:to_s) }

        it "updates the requested guide" do
          do_patch
          expect(guide.reload.attributes.slice(*expected_attributes.keys)).to eq expected_attributes
        end

        it { is_expected.to redirect_to guides_path }
      end

      context "with invalid parameters" do
        subject(:do_patch) do
          patch guide_path(guide), params: { guide: attributes_for(:guide, :invalid) }
          response
        end

        let(:expected_attributes) { guide.attributes.except(:photo).transform_keys(&:to_s) }

        it "does not update the requested guide" do
          do_patch
          expect(guide.reload.attributes.slice(*expected_attributes.keys)).to eq expected_attributes
        end

        it { is_expected.to have_http_status :unprocessable_entity }
      end
    end
  end

  describe "PATCH /move" do
    subject(:do_move) do
      patch move_guide_path guide, from: 0, to: 1
      response
    end

    let!(:guide) { create :guide }
    let!(:guide2) { create :guide }

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it { is_expected.to be_ok }

      it "moves the first guide to position 1" do
        do_move
        expect(guide.reload.position).to eq 1
      end

      it "moves the second guide to position 0" do
        do_move
        expect(guide2.reload.position).to eq 0
      end
    end
  end

  describe "DELETE /destroy" do
    subject(:do_delete) do
      delete guide_path guide
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it "destroys the requested guide" do
        guide # load the guide before the check that we delete it
        expect { do_delete }.to change(Guide, :count).by(-1)
      end

      it { is_expected.to redirect_to guides_path }
    end
  end
end
