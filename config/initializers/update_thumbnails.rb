Badge.find(:all).each do |badge| 
  badge.save_thumbnails unless File.exists?(File.join(badge.cache_path , 'full.gif' )) && File.exists?(File.join(badge.cache_path , 'medium.gif' )) && File.exists?(File.join(badge.cache_path , 'small.gif' ))
end

MyBadge.find(:all).each do |badge| 
  badge.save_thumbnails unless File.exists?(File.join(badge.cache_path , 'full.gif' )) && File.exists?(File.join(badge.cache_path , 'medium.gif' )) && File.exists?(File.join(badge.cache_path , 'small.gif' ))
end