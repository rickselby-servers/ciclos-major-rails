# frozen_string_literal: true

class CreateGuides < ActiveRecord::Migration[7.1]
  def change
    create_table :guides do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
