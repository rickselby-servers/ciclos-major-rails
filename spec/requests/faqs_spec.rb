# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/faqs" do
  let(:faq) { Faq.create! valid_attributes }
  let(:invalid_attributes) { { question: "", answer: "" } }
  let(:valid_attributes) { { question: "foo", answer: "bar" } }

  before(:each, :logged_in) do
    sign_in Admin.create
  end

  describe "GET /index" do
    subject do
      get faqs_url
      response
    end

    it { is_expected.to be_successful }
  end

  describe "GET /new" do
    subject do
      get new_faq_url
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it { is_expected.to be_successful }
    end
  end

  describe "GET /edit" do
    subject do
      get edit_faq_url faq
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it { is_expected.to be_successful }
    end
  end

  describe "POST /create" do
    subject(:do_post) do
      post faqs_url, params: { faq: valid_attributes }
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      context "with valid parameters" do
        it "creates a new Faq" do
          expect { do_post }.to change(Faq, :count).by(1)
        end

        it { is_expected.to redirect_to faqs_url }
      end

      context "with invalid parameters" do
        subject(:do_post) do
          post faqs_url, params: { faq: invalid_attributes }
          response
        end

        it "does not create a new Faq" do
          expect { do_post }.not_to change(Faq, :count)
        end

        it { is_expected.to have_http_status :unprocessable_entity }
      end
    end
  end

  describe "PATCH /update" do
    subject(:do_patch) do
      patch faq_url(faq), params: { faq: new_attributes }
      response
    end

    let(:new_attributes) { { question: "bar", answer: "baz" } }

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      context "with valid parameters" do
        let(:expected_attributes) { new_attributes.transform_keys(&:to_s) }

        it "updates the requested faq" do
          do_patch
          expect(faq.reload.attributes.slice(*expected_attributes.keys)).to eq expected_attributes
        end

        it { is_expected.to redirect_to faqs_url }
      end

      context "with invalid parameters" do
        subject(:do_patch) do
          patch faq_url(faq), params: { faq: invalid_attributes }
          response
        end

        let(:expected_attributes) { valid_attributes.transform_keys(&:to_s) }

        it "does not update the requested faq" do
          do_patch
          expect(faq.attributes.slice(*expected_attributes.keys)).to eq expected_attributes
        end

        it { is_expected.to have_http_status :unprocessable_entity }
      end
    end
  end

  describe "DELETE /destroy" do
    subject(:do_delete) do
      delete faq_url faq
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it "destroys the requested faq" do
        faq # load the FAQ before the check that we delete it
        expect { do_delete }.to change(Faq, :count).by(-1)
      end

      it { is_expected.to redirect_to faqs_url }
    end
  end
end
