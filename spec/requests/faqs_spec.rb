# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/faqs" do
  let(:faq) { create :faq }

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
      post faqs_url, params: { faq: attributes_for(:faq) }
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      context "with valid parameters" do
        it "creates a new FAQ" do
          expect { do_post }.to change(Faq, :count).by(1)
        end

        it { is_expected.to redirect_to faqs_url }
      end

      context "with invalid parameters" do
        subject(:do_post) do
          post faqs_url, params: { faq: attributes_for(:faq, :invalid) }
          response
        end

        it "does not create a new FAQ" do
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
          patch faq_url(faq), params: { faq: attributes_for(:faq, :invalid) }
          response
        end

        let(:expected_attributes) { faq.attributes.transform_keys(&:to_s) }

        it "does not update the requested faq" do
          do_patch
          expect(faq.reload.attributes.slice(*expected_attributes.keys)).to eq expected_attributes
        end

        it { is_expected.to have_http_status :unprocessable_entity }
      end
    end
  end

  describe "PATCH /move" do
    subject(:do_move) do
      patch move_faqs_path from: 0, to: 1
      response
    end

    let!(:faq) { create :faq }
    let!(:faq2) { create :faq }

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it { is_expected.to be_ok }

      it "moves the first faq to position 1" do
        do_move
        expect(faq.reload.position).to eq 1
      end

      it "moves the second faq to position 0" do
        do_move
        expect(faq2.reload.position).to eq 0
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
