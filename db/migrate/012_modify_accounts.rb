class ModifyAccounts < ActiveRecord::Migration
  def self.up
    add_column :accounts, :fullname, :string
    add_column :accounts, :nickname, :string
    add_column :accounts, :primary_email, :string
    add_column :accounts, :remember_token, :string
    add_column :accounts, :remember_token_expires_at, :datetime
    remove_column :accounts, :email
    remove_column :accounts, :first_name
    remove_column :accounts, :last_name
  end

  def self.down
    remove_column :accounts, :fullname
    remove_column :accounts, :nickname
    remove_column :accounts, :primary_email
    remove_column :accounts, :remember_token
    remove_column :accounts, :remember_token_expires_at
    add_column :accounts, :email, :string
    add_column :accounts, :first_name, :string
    add_column :accounts, :last_name, :string
  end
end
