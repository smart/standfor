class CreateCampaigns < ActiveRecord::Migration
  def self.up
    create_table :campaigns do |t|
      t.column :organization_id, :integer
      t.column :admin_id, :integer
      t.column :segment_id, :integer
      t.column :name, :string
      t.column :description , :text
      t.column :goal, :integer
      t.column :end_date, :date
      t.timestamps
    end
  end

  def self.down
    drop_table :campaigns
  end
end
