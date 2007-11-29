class Avatar < ActiveRecord::Base
  belongs_to :account
  acts_as_attachment :storage => :file_system, :content_type => :image
  THUMBS = { :full => 150, :thumb => 75, :small => 25 }
  validates_as_attachment

  after_attachment_saved do |photo|
    if photo.parent_id.nil?
      THUMBS.each_pair do |file_name_suffix, size|
       thumb = thumbnail_class.find_or_initialize_by_thumbnail_and_parent_id(file_name_suffix.to_s, photo.id)
        resized_image = photo.crop_resized_image(size)
        unless resized_image.nil?
          thumb.attributes = {
            :content_type    => photo.content_type, 
            :filename        => photo.thumbnail_name_for(file_name_suffix.to_s), 
            :attachment_data => resized_image
          }
          thumb.save!
        end
      end
    end    
  end

  def crop_resized_image(size)
    thumb = nil
    with_image do |img|
      thumb = img.crop_resized(size, size)
    end
    thumb
  end

end
