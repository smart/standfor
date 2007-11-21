class AddFeaturedToSponsorsAndOrganizations < ActiveRecord::Migration

  def self.up
    add_column :organizations, :featured, :boolean, :default => false
    add_column :sponsors, :featured, :boolean, :default => false
  end

  def self.down
    remove_column :organizations, :featured
    remove_column :sponsors, :featured
  end

end
