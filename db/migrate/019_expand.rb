class Expand < ActiveRecord::Migration
  def self.up
    change_column :organizations, :description, :text
    add_column :segments, :description, :text
  end

  def self.down
    change_column :organizations, :description, :string
    remove_column :segments, :description
  end
end
