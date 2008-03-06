class AddResetPasswordToAccount < ActiveRecord::Migration
  def self.up
    add_column :accounts, :reset_password_code, :string
  end

  def self.down
    remove_column :accounts, :reset_password_code
  end
end
