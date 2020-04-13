class AddDeleteAtToItem < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :delete_at, :datetime
    add_index :items, :delete_at
  end
end
