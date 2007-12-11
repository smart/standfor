class AddRefererToAccount < ActiveRecord::Migration
  def self.up
    add_column :accounts, :my_badge_referrer, :integer
  end

  def self.down
    remove_column :accounts, :my_badge_referrer
  end
end
