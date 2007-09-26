class AddAdminIdToOrganization < ActiveRecord::Migration

  def self.up
     add_column :organizations, :admin_id, :integer
  end

  def self.down
     remove_column :organizations, :admin_id
  end

end
