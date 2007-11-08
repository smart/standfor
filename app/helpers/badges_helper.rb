module BadgesHelper
  def badge_link(badge)
  	link = link_to(image_tag("placeholders/imageselections.jpg"), badge_path(badge))
  	meta = content_tag(:li, badge.name)
  	meta << content_tag(:li, "Organization: " + badge.organization.name)
  	meta << content_tag(:li, "Cause: " + badge.segment.name)
  	meta << content_tag(:li, link_to("Get this Badge", badge_path(badge)))
  	meta = content_tag(:ul, meta)
  	meta = content_tag(:div, meta, :class => 'badge-meta')
    html = content_tag(:div, meta + link, :class => 'badge-link')
    html
  end
end
