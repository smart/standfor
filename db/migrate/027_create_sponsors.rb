class CreateSponsors < ActiveRecord::Migration
  def self.up
    create_table :sponsors do |t|
      t.string :name 
      t.string :site_name
      t.string :logo
      t.column :address1,   :string
      t.column :address2,   :string
      t.column :address3,   :string
      t.column :city,       :string
      t.column :state,      :string 
      t.column :zip,        :string
      t.column :country,    :string
      t.column :phone,      :string
      t.column :fax,        :string
      t.column :email,      :string
      t.column :url,        :string
      t.column :statement, :text
      t.timestamps 
    end

    create_table :sponsorships do |t|
       t.integer :sponsor_id
       t.integer :max_amount
       t.date :start_date 
       t.date :end_date
       t.integer :num_golden_links
       t.float :golden_link_rate
       t.float :click_rate
       t.float :unique_rate
       t.float :hit_rate
       t.float :awareness_point_rate
       t.string :type
       t.integer :sponsorable_id
       t.string  :sponsorable_type
    end
   
  end

  def self.down
    drop_table :sponsors
    drop_table :sponsorships
  end

end
