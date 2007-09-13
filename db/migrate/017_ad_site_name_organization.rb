class AdSiteNameOrganization < ActiveRecord::Migration

  def self.up
    add_column :organizations, :site_name, :string
  end

  def self.down
    remove_column :organizations, :site_name
  end

end
