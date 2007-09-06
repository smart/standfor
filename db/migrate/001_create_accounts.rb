class CreateAccounts < ActiveRecord::Migration

  def self.up
    create_table :accounts do |t|
      t.column :first_name , :string
      t.column :last_name  , :string
      t.column :phone      , :string
      t.column :email      , :string
      t.column :city       , :string
      t.column :state      , :string
      t.column :zip        , :string
      t.column :created_at , :date
      t.column :updated_at , :date
      t.column :status     , :boolean, :default => true
    end
  end

  def self.down
    drop_table :accounts
  end

end
