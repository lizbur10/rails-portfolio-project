class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.datetime :date
      t.text :content
      t.text :status, :default => "draft"
      t.integer :bander_id

      t.timestamps
    end
  end
end
