class CreateDonations < ActiveRecord::Migration

  def self.up
    create_table :donations do |t|
      t.column :account_id, :integer
      t.column :organization_id, :integer
      t.column :amount, :integer
      t.column :segment_id, :integer
      t.column :payment_authorization, :string
      t.column :last_four_digits, :string, :limit => 4
      t.timestamps 
    end
  end

  def self.down
    drop_table :donations
  end

end
