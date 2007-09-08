class CreateAccountBadgeAuthorizations < ActiveRecord::Migration
  def self.up
    create_table :account_badge_authorizations do |t|
       t.column :account_id, :integer
       t.column :badge_id, :integer
       t.column :badge_access_code_id, :integer
      t.timestamps 
    end
  end

  def self.down
    drop_table :account_badge_authorizations
  end
end
