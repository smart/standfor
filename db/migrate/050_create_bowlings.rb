class CreateBowlings < ActiveRecord::Migration
  def self.up
    create_table :bowlings do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :bowlings
  end
end
