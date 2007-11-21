class AddFeaturedToBadges < ActiveRecord::Migration
  def self.up
    add_column :badges, :featured, :boolean, :default => false
  end

  def self.down
    remove_column :badges, :featured
  end
end
