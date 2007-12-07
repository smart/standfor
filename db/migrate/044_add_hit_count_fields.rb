class AddHitCountFields < ActiveRecord::Migration
  def self.up
    add_column :badges, :hits, :integer, :default => 0
    add_column :accounts, :hits, :integer, :default => 0
  end

  def self.down
    remove_column :badges, :hits
    remove_column :accounts, :hits
  end

end
