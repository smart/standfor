class BadgeAccessCodes < ActiveRecord::Migration
  def self.up
    create_table :badge_access_codes do |t|
      t.column :badge_id, :integer
      t.column :value, :string
    end
  end

  def self.down
    drop_table :badge_access_codes
  end

end
