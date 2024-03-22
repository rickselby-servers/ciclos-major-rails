# frozen_string_literal: true

class CreatePhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :photos do |t|
      t.references :photoable, polymorphic: true, null: false
      t.integer :position
      t.string :alt

      t.timestamps
    end
  end
end
