class AddPublicAdiIdToMyBadge < ActiveRecord::Migration
  def self.up
    add_column :my_badges, :public_adi_id, :string
  end

  def self.down
    remove_column :my_badges, :public_adi_id
  end
end
