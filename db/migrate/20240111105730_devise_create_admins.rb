# frozen_string_literal: true

class DeviseCreateAdmins < ActiveRecord::Migration[7.1]
  def change
    create_table :admins do |t|
      t.string :email,    null: false, default: ""
      t.string :provider, null: false, default: ""
      t.string :uid,      null: false, default: ""

      t.timestamps null: false
    end

    add_index :admins, :email, unique: true
  end
end
