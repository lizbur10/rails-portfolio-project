class CreateBirds < ActiveRecord::Migration[5.1]
  def change
    create_table :birds do |t|
      t.datetime :banding_date
      t.integer :bander_id
      t.integer :species_id
      t.integer :report_id

      t.timestamps
    end
  end
end
