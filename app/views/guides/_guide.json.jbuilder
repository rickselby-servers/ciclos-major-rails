# frozen_string_literal: true

json.extract! guide, :id, :name, :description, :photo, :created_at, :updated_at
json.url guide_url(guide, format: :json)
json.photo url_for(guide.photo)
