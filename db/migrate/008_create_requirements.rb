class CreateRequirements < ActiveRecord::Migration

  def self.up
    create_table :requirements do |t|
      t.column :badge_id, :integer
      t.column :name, :string
      t.column :value, :string
      t.column :description, :string
      t.column :type, :string
    end
  end

  def self.down
    drop_table :requirements
  end
end
