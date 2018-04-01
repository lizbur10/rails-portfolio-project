class CreateBirdsOfSpecies < ActiveRecord::Migration[5.1]
  def change
    create_table :birds_of_species do |t|
      t.integer :number_banded
      t.integer :bander_id
      t.integer :species_id
      t.integer :report_id

      t.timestamps
    end
  end
end
