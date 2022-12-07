# fronze_string_literal: true

class CreateAstronautsNameIndex < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    enable_extension :pg_trgm

    add_index :astronauts, %i[first_name last_name], name: :index_name, using: :gin,
      algorithm: :concurrently, opclass: {first_name: :gin_trgm_ops, last_name: :gin_trgm_ops}
  end
end
