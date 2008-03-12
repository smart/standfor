class AddYounetyTokenToAccount < ActiveRecord::Migration
  def self.up
    add_column :accounts, :younety_token, :string
  end

  def self.down
    remove_column :accounts, :younety_token
  end
end
