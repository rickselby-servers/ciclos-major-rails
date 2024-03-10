# frozen_string_literal: true

class CreateGalleries < ActiveRecord::Migration[7.1]
  def change
    create_table :galleries do |t|
      t.string :name
      t.date :date

      t.timestamps
    end
  end
end
