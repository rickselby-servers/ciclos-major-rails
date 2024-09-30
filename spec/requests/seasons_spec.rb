# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/seasons" do
  let(:season) { create :season }

  describe "GET /index" do
    subject do
      get seasons_path
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it { is_expected.to be_successful }
    end
  end

  describe "GET /show" do
    subject do
      get season_url(season)
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it { is_expected.to be_successful }
    end
  end

  describe "GET /new" do
    subject do
      get new_season_path
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it { is_expected.to be_successful }
    end
  end

  describe "GET /edit" do
    subject do
      get edit_season_url(season)
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it { is_expected.to be_successful }
    end
  end

  describe "POST /create" do
    subject(:do_post) do
      post seasons_path, params: { season: attributes_for(:season) }
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      context "with valid parameters" do
        it "creates a new Season" do
          expect { do_post }.to change(Season, :count).by(1)
        end

        it { is_expected.to redirect_to season_path(Season.last) }
      end

      context "with invalid parameters" do
        subject(:do_post) do
          post seasons_path, params: { season: attributes_for(:season, :invalid) }
          response
        end

        it "does not create a new Season" do
          expect { do_post }.not_to change(Season, :count)
        end

        it { is_expected.to have_http_status :unprocessable_entity }
      end
    end
  end

  describe "PATCH /update" do
    subject(:do_patch) do
      patch season_url(season), params: { season: new_attributes }
      response
    end

    let(:new_attributes) { attributes_for :season }

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      context "with valid parameters" do
        let(:expected_attributes) { new_attributes.except(:photo).transform_keys(&:to_s) }

        it "updates the requested season" do
          do_patch
          expect(season.reload.attributes.slice(*expected_attributes.keys)).to eq expected_attributes
        end

        it { is_expected.to redirect_to season_path(season.reload) }
      end

      context "with invalid parameters" do
        subject(:do_patch) do
          patch season_url(season), params: { season: attributes_for(:season, :invalid) }
          response
        end

        let(:expected_attributes) { season.attributes.transform_keys(&:to_s) }

        it "does not update the requested season" do
          do_patch
          expect(season.reload.attributes.slice(*expected_attributes.keys)).to eq expected_attributes
        end

        it { is_expected.to have_http_status :unprocessable_entity }
      end
    end
  end

  describe "DELETE /destroy" do
    subject(:do_delete) do
      delete season_url(season)
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it "destroys the requested season" do
        season # load the season before the check that we delete it
        expect { do_delete }.to change(Season, :count).by(-1)
      end

      it { is_expected.to redirect_to seasons_path }
    end
  end
end
