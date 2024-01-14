# frozen_string_literal: true

class CreatePageTexts < ActiveRecord::Migration[7.1]
  def change
    create_table :page_texts do |t|
      t.string :key
      t.text :text

      t.timestamps
    end

    add_index :page_texts, :key, unique: true
  end
end
