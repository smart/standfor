module BadgesHelper
  def badge_link(badge, path)
  	link = link_to(image_tag("placeholders/imageselections.jpg"), path)
  	mouseover = "Element.show('#{dom_id(badge)}')"
  	mouseout = "Element.hide('#{dom_id(badge)}')"
  	meta = content_tag(:li, badge.name)
  	meta << content_tag(:li, "Organization: " + badge.organization.name)
  	meta << content_tag(:li, "Cause: " + badge.segment.name)
  	meta << content_tag(:li, link_to("View this Badge", path))
  	meta = content_tag(:ul, meta)
  	meta = link_to(image_tag("placeholders/mediumbadge.jpg"), path) + meta
  	meta = content_tag(:div, meta, :class => 'badge-meta', :id => dom_id(badge), :style => "display:none;")
    html = content_tag(:div, meta + link, :class => 'badge-link', :onmouseover => mouseover, :onmouseout => mouseout)
    html
  end
  
  def show_badge_meta(badge)
  	
	end
end
