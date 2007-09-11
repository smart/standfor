class CreateAuthorization < ActiveRecord::Migration

  def self.up
     create_table :authorizations do |t|
       t.column :badge_id, :integer
       t.column :account_id, :integer
       t.column :authorization_code, :string
       t.column :last_four_digits, :string
       t.column :status, :boolean, :default => true 
       t.timestamps
     end
  end

  def self.down
     drop_table :authorizations
  end

end
