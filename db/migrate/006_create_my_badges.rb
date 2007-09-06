class CreateMyBadges < ActiveRecord::Migration
  def self.up
    create_table :my_badges do |t|
      t.column :badge_id, :integer
      t.column :account_id, :integer
      t.timestamps 
    end
  end

  def self.down
    drop_table :my_badges
  end
end
