class CreateSponsors < ActiveRecord::Migration
  def self.up
    create_table :sponsors do |t|
      t.string :name 
      t.timestamps 
    end

    create_table :sponsorships do |t|
       t.integer :sponsor_id
       t.integer :sponsorable_id
       t.string  :sponsorable_type
    end
   
  end

  def self.down
    drop_table :sponsors
    drop_table :sponsorships
  end

end
