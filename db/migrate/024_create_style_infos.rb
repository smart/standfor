class CreateStyleInfos < ActiveRecord::Migration
  def self.up
    create_table :style_infos do |t|
      t.column :scope_type, :string, :null => false
      t.column :scope_id, :integer, :null => false
      t.column :color_primary, :string, :null => false
      t.column :color_secondary, :string, :null => true
      t.column :color_third, :string, :null => true
      t.column :color_standfor_1, :string, :null => true
      t.column :color_standfor_2, :string, :null => true
      t.column :color_header_1, :string, :null => true
      t.column :color_header_2, :string, :null => true
      t.column :color_button_1, :string, :null => true
      t.column :color_button_2, :string, :null => true
      t.column :color_fill_1, :string, :null => true
      t.column :color_fill_2,:string, :null => true
      t.timestamps 
    end
  end

  def self.down
    drop_table :style_infos
  end
end
