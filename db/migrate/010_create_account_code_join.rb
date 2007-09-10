class CreateAccountCodeJoin < ActiveRecord::Migration

  def self.up
     create_table :access_codes_accounts, :id => false do |t|
        t.column :access_code_id, :integer
        t.column :account_id, :integer
     end
  end

  def self.down
     drop_table :access_codes_accounts
  end

end
