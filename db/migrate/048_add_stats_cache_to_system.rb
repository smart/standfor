class AddStatsCacheToSystem < ActiveRecord::Migration
  def self.up
    add_column :my_badges, :total_hits, :integer, :default => 0
    add_column :my_badges, :total_clicks, :integer, :default => 0
    add_column :my_badges, :total_unique_hits, :integer, :default => 0
    add_column :my_badges, :total_unique_clicks, :integer, :default => 0
    add_column :my_badges, :awareness_points, :integer, :default => 0
    add_column :my_badges, :stats_updated_at, :datetime, :default => nil, :null => true
    
    add_column :accounts, :total_hits, :integer, :default => 0
    add_column :accounts, :total_clicks, :integer, :default => 0
    add_column :accounts, :total_unique_hits, :integer, :default => 0
    add_column :accounts, :total_unique_clicks, :integer, :default => 0
    add_column :accounts, :awareness_points, :integer, :default => 0
    add_column :accounts, :stats_updated_at, :datetime, :default => nil, :null => true
  end

  def self.down
    remove_column :my_badges, :total_hits
    remove_column :my_badges, :total_clicks
    remove_column :my_badges, :total_unique_hits
    remove_column :my_badges, :total_unique_clicks
    remove_column :my_badges, :awareness_points
    remove_column :my_badges, :stats_updated_at
    
    remove_column :accounts, :total_hits
    remove_column :accounts, :total_clicks
    remove_column :accounts, :total_unique_hits
    remove_column :accounts, :total_unique_clicks
    remove_column :accounts, :awareness_points
    remove_column :accounts, :stats_updated_at
  end
end
