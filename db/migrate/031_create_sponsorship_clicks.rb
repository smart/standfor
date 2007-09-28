class CreateSponsorshipClicks < ActiveRecord::Migration
  def self.up
    create_table :sponsorship_clicks do |t|
      t.column :sponsorship_id , :integer
      t.column :my_badge_id, :integer
      t.column :golden, :boolean, :default => false
      t.column :sponsorship_hit_id, :integer
      t.column :ip, :string 
      t.column :referrer, :string
      t.column :cookies, :string 
      t.timestamps 
    end
  end

  def self.down
    drop_table :sponsorship_clicks
  end
end
