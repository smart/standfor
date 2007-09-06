class CreateBadges < ActiveRecord::Migration
  def self.up
    create_table :badges do |t|
      t.column :name, :string
      t.column :organization_id, :integer
      t.column :segment_id, :integer
      t.column :structure_id, :integer
      t.timestamps 
    end
  end

  def self.down
    drop_table :badges
  end
end
