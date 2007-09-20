class AddCampaignToBadge < ActiveRecord::Migration
  def self.up
    add_column :badges, :campaign_id, :integer 
  end

  def self.down
    remove_column :badges, :campaign_id
  end
end
