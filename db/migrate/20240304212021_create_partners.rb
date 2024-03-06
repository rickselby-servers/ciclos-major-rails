# frozen_string_literal: true

class CreatePartners < ActiveRecord::Migration[7.1]
  def change
    create_table :partners do |t|
      t.string :name
      t.text :details
      t.string :url
      t.integer :position

      t.timestamps
    end
  end
end
