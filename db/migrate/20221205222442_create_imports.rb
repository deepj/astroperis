# frozen_string_literal: true

class CreateImports < ActiveRecord::Migration[7.0]
  def change
    create_table :imports do |table|
      table.string :file_name, null: false
      table.references :user, null: false, foreign_key: true
      table.integer :state, null: false, default: 0
      table.jsonb :file_data

      table.datetime :started_at
      table.datetime :finished_at
      table.datetime :failed_at

      table.timestamps
    end
  end
end
