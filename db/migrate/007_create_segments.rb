class CreateSegments < ActiveRecord::Migration
  def self.up
    create_table :segments do |t|
       t.column :name, :string
       t.column :keyword, :string
       t.column :organization_id, :integer
       t.timestamps
    end
  end

  def self.down
    drop_table :segments
  end
end
