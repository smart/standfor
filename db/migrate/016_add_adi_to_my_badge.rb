class AddAdiToMyBadge < ActiveRecord::Migration
  def self.up
    add_column :my_badges, :adi_id, :integer
  end

  def self.down
    remove_column :my_badges, :adi_id
  end
end
