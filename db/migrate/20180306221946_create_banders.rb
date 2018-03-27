class CreateBanders < ActiveRecord::Migration[5.1]
  def change
    create_table :banders do |t|
      t.text :name

      t.timestamps
    end
  end
end
