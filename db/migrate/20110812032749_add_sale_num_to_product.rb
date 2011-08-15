class AddSaleNumToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :sale_num, :integer,:default=>0
  end

  def self.down
    remove_column :products, :sale_num
  end
end
