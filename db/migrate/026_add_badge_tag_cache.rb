class AddBadgeTagCache < ActiveRecord::Migration
  def self.up
    add_column :badges, :cached_tag_list, :string
  end

  def self.down
    remove_column :badges, :cached_tag_list
  end
end
