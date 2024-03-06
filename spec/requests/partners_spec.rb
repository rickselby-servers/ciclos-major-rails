# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/partners" do
  let(:partner) { create :partner }

  describe "GET /index" do
    subject do
      get partners_path
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it { is_expected.to be_successful }
    end
  end

  describe "GET /new" do
    subject do
      get new_partner_path
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it { is_expected.to be_successful }
    end
  end

  describe "GET /show" do
    subject do
      get partner_path partner
      response
    end

    it { is_expected.to be_successful }
  end

  describe "GET /edit" do
    subject do
      get edit_partner_path partner
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it { is_expected.to be_successful }
    end
  end

  describe "POST /create" do
    subject(:do_post) do
      post partners_path, params: { partner: attributes_for(:partner) }
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      context "with valid parameters" do
        it "creates a new Partner" do
          expect { do_post }.to change(Partner, :count).by(1)
        end

        it { is_expected.to redirect_to partners_path }
      end

      context "with invalid parameters" do
        subject(:do_post) do
          post partners_path, params: { partner: attributes_for(:partner, :invalid) }
          response
        end

        it "does not create a new Partner" do
          expect { do_post }.not_to change(Partner, :count)
        end

        it { is_expected.to have_http_status :unprocessable_entity }
      end
    end
  end

  describe "PATCH /update" do
    subject(:do_patch) do
      patch partner_url(partner), params: { partner: new_attributes }
      response
    end

    let(:new_attributes) { attributes_for :partner }

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      context "with valid parameters" do
        let(:expected_attributes) { new_attributes.except(:logo).transform_keys(&:to_s) }

        it "updates the requested partner" do
          do_patch
          expect(partner.reload.attributes.slice(*expected_attributes.keys)).to eq expected_attributes
        end

        it { is_expected.to redirect_to partners_path }
      end

      context "with invalid parameters" do
        subject(:do_patch) do
          patch partner_url(partner), params: { partner: attributes_for(:partner, :invalid) }
          response
        end

        let(:expected_attributes) { partner.attributes.transform_keys(&:to_s) }

        it "does not update the requested partner" do
          do_patch
          expect(partner.reload.attributes.slice(*expected_attributes.keys)).to eq expected_attributes
        end

        it { is_expected.to have_http_status :unprocessable_entity }
      end
    end
  end

  describe "DELETE /destroy" do
    subject(:do_delete) do
      delete partner_url(partner)
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it "destroys the requested partner" do
        partner # load the partner before the check that we delete it
        expect { do_delete }.to change(Partner, :count).by(-1)
      end

      it { is_expected.to redirect_to partners_path }
    end
  end
end
