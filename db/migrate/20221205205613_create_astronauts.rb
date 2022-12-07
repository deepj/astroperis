# frozen_string_literal: true

class CreateAstronauts < ActiveRecord::Migration[7.0]
  def change
    create_table :astronauts do |table|
      table.string :first_name
      table.string :last_name
      table.string :position
      table.integer :age
      table.string :country_code

      table.timestamps
    end
  end
end
