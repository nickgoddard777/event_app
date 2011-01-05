class AddPageTypeUniquenessIndex < ActiveRecord::Migration
  def self.up
  	add_index :pages, :page_type, :unique => true
  end

  def self.down
  	remove_index :pages, :page_type
  end
end
