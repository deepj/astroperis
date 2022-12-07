# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |table|
      table.string :first_name
      table.string :last_name
      table.string :email
      table.string :provider, null: false
      table.string :uid, null: false

      ## Rememberable
      table.datetime :remember_created_at

      table.timestamps null: false
    end

    add_index :users, %i[provider uid], unique: true
  end
end
