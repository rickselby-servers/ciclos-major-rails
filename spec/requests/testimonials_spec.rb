# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/testimonials" do
  let(:testimonial) { create :testimonial }

  describe "GET /index" do
    subject do
      get testimonials_url
      response
    end

    it { is_expected.to be_successful }
  end

  describe "GET /new" do
    subject do
      get new_testimonial_url
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it { is_expected.to be_successful }
    end
  end

  describe "GET /edit" do
    subject do
      get edit_testimonial_url testimonial
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it { is_expected.to be_successful }
    end
  end

  describe "POST /create" do
    subject(:do_post) do
      post testimonials_url, params: { testimonial: attributes_for(:testimonial) }
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      context "with valid parameters" do
        it "creates a new testimonial" do
          expect { do_post }.to change(Testimonial, :count).by(1)
        end

        it { is_expected.to redirect_to testimonials_url }
      end

      context "with invalid parameters" do
        subject(:do_post) do
          post testimonials_url, params: { testimonial: attributes_for(:testimonial, :invalid) }
          response
        end

        it "does not create a new testimonial" do
          expect { do_post }.not_to change(Testimonial, :count)
        end

        it { is_expected.to have_http_status :unprocessable_entity }
      end
    end
  end

  describe "PATCH /update" do
    subject(:do_patch) do
      patch testimonial_url(testimonial), params: { testimonial: new_attributes }
      response
    end

    let(:new_attributes) { attributes_for :testimonial }

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      context "with valid parameters" do
        let(:expected_attributes) { new_attributes.transform_keys(&:to_s) }

        it "updates the requested testimonial" do
          do_patch
          expect(testimonial.reload.attributes.slice(*expected_attributes.keys)).to eq expected_attributes
        end

        it { is_expected.to redirect_to testimonials_url }
      end

      context "with invalid parameters" do
        subject(:do_patch) do
          patch testimonial_url(testimonial), params: { testimonial: attributes_for(:testimonial, :invalid) }
          response
        end

        let(:expected_attributes) { testimonial.attributes.transform_keys(&:to_s) }

        it "does not update the requested testimonial" do
          do_patch
          expect(testimonial.reload.attributes.slice(*expected_attributes.keys)).to eq expected_attributes
        end

        it { is_expected.to have_http_status :unprocessable_entity }
      end
    end
  end

  # New testimonials are added at the top of the list!
  describe "PATCH /move" do
    subject(:do_move) do
      patch move_testimonial_path testimonial, from: 1, to: 0
      response
    end

    let!(:testimonial) { create :testimonial }
    let!(:testimonial2) { create :testimonial }

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it { is_expected.to be_ok }

      it "moves the first testimonial to position 0" do
        do_move
        expect(testimonial.reload.position).to eq 0
      end

      it "moves the second testimonial to position 1" do
        do_move
        expect(testimonial2.reload.position).to eq 1
      end
    end
  end

  describe "DELETE /destroy" do
    subject(:do_delete) do
      delete testimonial_path testimonial
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it "destroys the requested testimonial" do
        testimonial # load the testimonial before the check that we delete it
        expect { do_delete }.to change(Testimonial, :count).by(-1)
      end

      it { is_expected.to redirect_to testimonials_url }
    end
  end
end
