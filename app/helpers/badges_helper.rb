module BadgesHelper
  def badge_link(badge, path)
  	link = link_to(image_tag("placeholders/imageselections.jpg"), path)
  	meta = content_tag(:li, badge.name)
  	meta << content_tag(:li, "Organization: " + badge.organization.name)
  	meta << content_tag(:li, "Cause: " + badge.segment.name)
  	meta << content_tag(:li, link_to("Get this Badge", badge_path(badge)))
  	meta = content_tag(:ul, meta)
  	meta = link + meta
  	meta = content_tag(:div, meta, :class => 'badge-meta', :id => dom_id(badge))
    html = content_tag(:div, meta + link, :class => 'badge-link')
    html
  end
  
  def show_badge_meta(badge)
  	
	end
end
