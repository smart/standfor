module BadgesHelper
  def badge_link(badge, path, opts = {} )
    opts[:size] ||=  'medium'
  	link = link_to(image_tag( badge.source_path(:size => opts[:size])), path ) 
  	mouseover = "Element.show('#{dom_id(badge)}')"
  	mouseout = "Element.hide('#{dom_id(badge)}')"
  	meta = content_tag(:li, "<h4>#{badge.name}</h4>")
  	meta << content_tag(:li, "<strong>Organization:</strong> " + link_to(badge.organization.name, organization_path(badge.organization.site_name)) )
  	meta << content_tag(:li, "<strong>Cause:</strong> " + badge.segment.name)
  	meta << content_tag(:li, link_to(image_tag('icons/navigation/get_badge.png', :alt => "Get Badge"), path))
  	meta = content_tag(:ul, meta)
  	meta = link_to(image_tag( badge.source_path(:size => 'medium'), :class => 'preview') , path) + meta
  	meta = content_tag(:div, meta, :class => 'badge-meta', :id => dom_id(badge), :style => "display:none;")
    html = content_tag(:div, meta + link, :class => 'badge-link', :onmouseover => mouseover, :onmouseout => mouseout)
    html
  end
  
  def show_badge_meta(badge)
	end
	
	def show_requirements(my_badge, requirement)
		case
		when requirement == DonationRequirement
			return content_tag(:li, "Make a donation to #{my_badge.organization.name}.", :class => 'donate')
		when requirement == CodeRequirement
			return content_tag(:li, "Enter an access code from #{my_badge.organization.name}", :class => 'access')
		else
			return content_tag(:li, "You have met all the requirements for this badge", :class => 'met')
		end
	end
	
	def my_badge_options(text, option, url)
		link = link_to(text, url)
		link = content_tag(:span, link)
		
		button = content_tag(:li, link, :class => option, :onmouseover => toggle_option_text(option, 'show'), :onmouseout => toggle_option_text(option, 'hide'))
	end
	
	def toggle_option_text(option, state)
		update_page do |page|
			page.select("li.#{option} span").each do |item|
				(state == 'show') ? item.add_class_name('show') : item.remove_class_name('show')
			end
		end
	end

  def featured_options
    [ ['Yes', 1] , ['No', 0] ]
  end

end
