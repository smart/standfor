class AdSiteNameToSegment < ActiveRecord::Migration
  def self.up
     add_column :segments, :site_name, :string
  end

  def self.down
     remove_column :segments, :site_name
  end
end
