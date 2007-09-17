class AddDescriptionToBadge < ActiveRecord::Migration
  def self.up
    add_column :badges, :description, :text
  end

  def self.down
    remove_column :badges, :description
  end
end
