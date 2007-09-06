class CreateOrganizations < ActiveRecord::Migration

  def self.up
     create_table :organizations do |t|
       t.column :name,       :string
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
       t.column :statement,  :string
       t.column :description,:string
       t.column :created_on, :date
       t.column :updated_on, :date
     end
  end

  def self.down
     drop_table :organizations
  end

end
