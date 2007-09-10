class CreateAccessCodes < ActiveRecord::Migration

  def self.up
    create_table :access_codes do |t|
      t.column :scope_id, :integer, :null => false
      t.column :scope_type, :string, :default => 'CodeRequirement', :null => false
      t.column :value, :string, :null => false
    end
  end

  def self.down
    drop_table :access_codes
  end

end
