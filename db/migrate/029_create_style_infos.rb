class CreateStyleInfos < ActiveRecord::Migration
  def self.up
    create_table :style_infos do |t|

      t.timestamps 
    end
  end

  def self.down
    drop_table :style_infos
  end
end
