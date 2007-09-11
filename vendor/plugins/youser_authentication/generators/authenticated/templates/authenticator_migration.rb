class CreateAuthenticators < ActiveRecord::Migration
  def self.up
    
    create_table :authenticators do |t|
      t.column :auth_type, :string, :null => false
      t.column :auth_token, :string
      t.column :<%= file_name %>_id, :integer
      t.timestamps 
    end
  end

  def self.down
    drop_table :authenticators
  end
end
