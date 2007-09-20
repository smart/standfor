class AddRoleSupport < ActiveRecord::Migration
  def self.up

  create_table "roles", :force => true do |t|
    t.column "title", :string
  end

  create_table "accounts_roles", :id => false, :force => true do |t|
    t.column "account_id", :integer
    t.column "role_id", :integer
  end
  

  end

  def self.down
     drop_table "roles"
     drop_table "accounts_roles"
  end
end
