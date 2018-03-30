class AddPasswordDigestToBanders < ActiveRecord::Migration[5.1]
  def change
    add_column :banders, :password_digest, :string
  end
end
