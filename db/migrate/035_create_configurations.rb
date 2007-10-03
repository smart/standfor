class CreateConfigurations < ActiveRecord::Migration
  def self.up
    create_table :configurations do |t|
      t.string :name 
      t.integer :organization_id
      t.text :welcome_message
      t.text :news
      t.timestamps 
    end
  end

  def self.down
    drop_table :configurations
  end
end
