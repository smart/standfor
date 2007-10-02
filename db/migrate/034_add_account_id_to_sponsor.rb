class AddAccountIdToSponsor < ActiveRecord::Migration
  def self.up
    add_column :sponsors, :account_id, :integer
  end

  def self.down
    remove_column :sponsors, :account_id
  end

end
