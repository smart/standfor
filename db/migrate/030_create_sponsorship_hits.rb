class CreateSponsorshipHits < ActiveRecord::Migration

  def self.up
    create_table :sponsorship_hits do |t|
      t.column :my_badge_id, :integer
      t.column :sponsorship_id, :integer
      t.column :golden, :boolean, :default => false
      t.column :ip, :string 
      t.column :domain, :string
      t.column :host, :string
      t.column :referrer, :string
      t.column :cookies, :string 
      t.timestamps
    end
  end

  def self.down
    drop_table :sponsorship_hits
  end
end