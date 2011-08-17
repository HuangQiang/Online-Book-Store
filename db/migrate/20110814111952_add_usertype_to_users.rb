class AddUsertypeToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :usertype, :integer
  end

  def self.down
    remove_column :users, :usertype
  end
end
