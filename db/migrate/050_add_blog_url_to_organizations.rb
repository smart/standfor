class AddBlogUrlToOrganizations < ActiveRecord::Migration
  def self.up
    add_column :organizations, :blog_url, :text
  end

  def self.down
    remove_column :organizations, :blog_url
  end
end
