module BadgesHelper
  def badge_link(badge)
     html = content_tag(:div, link_to(image_tag("examples/#{badge.id}.gif"), badge_path(badge)  ), :class => 'badge-link')
     html
  end
end
