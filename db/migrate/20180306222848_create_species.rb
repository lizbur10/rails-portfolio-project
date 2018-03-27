class CreateSpecies < ActiveRecord::Migration[5.1]
  def change
    create_table :species do |t|
      t.text :code
      t.text :name

      t.timestamps
    end
  end
end
