class CreateDonations < ActiveRecord::Migration

  def self.up
    create_table :donations do |t|
      t.column :account_id, :integer
      t.column :organization_id, :integer
      t.column :amount, :integer
      t.timestamps 
    end
  end

  def self.down
    drop_table :donations
  end

end
