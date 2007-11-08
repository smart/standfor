class MoreOptionsMyBadges < ActiveRecord::Migration
  def self.up
    add_column :my_badges, :sponsorship_option ,:string
    add_column :my_badges, :merit_option, :string
  end

  def self.down
    remove_column :my_badges, :sponsorship_option
    remove_column :my_badges, :merit_option
  end
end
