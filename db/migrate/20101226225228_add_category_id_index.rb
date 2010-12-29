class AddCategoryIdIndex < ActiveRecord::Migration
  def self.up
  	add_index	:events, :category_id
  end

  def self.down
  	remove_index :events, :category_id
  end
end
