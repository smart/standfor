module BadgesHelper
  def badge_link(badge, opts = {})
    opts[:size] ||=  'medium'
    badge_type = check_badge_type(badge)
    badge_type == 'Badge' ? path = badge_path(badge) : path = user_my_badge_path(badge)
  	link = link_to(image_tag( badge.source_path(:size => opts[:size]), :class => "badge"), path ) 
  	mouseover = "Element.show('#{dom_id(badge)}')"
  	mouseout = "Element.hide('#{dom_id(badge)}')"
  	meta = content_tag(:li, "<h4>#{badge.name}</h4>")
  	meta << content_tag(:li, "<strong>Organization:</strong> " + link_to(badge.organization.name, organization_path(badge.organization.site_name)) )
  	meta << content_tag(:li, "<strong>Cause:</strong> " + badge.segment.name)
  	meta << content_tag(:li, customize_link(badge) + link_to(image_tag('icons/navigation/view_badge.png', :alt => "View Badge"), get_badge_path(badge)))
  	meta = content_tag(:ul, meta)
  	meta = link_to(image_tag( badge.source_path(:size => 'medium'), :class => 'preview') , path) + meta
  	meta = content_tag(:div, meta, :class => 'badge-meta', :id => dom_id(badge), :style => "display:none;")
    html = content_tag(:div, meta + link, :class => 'badge-link', :onmouseover => mouseover, :onmouseout => mouseout)
    html
  end
  
  def customize_link(badge, opts = {})
   	opts[:type] ||= badge.class.to_s
		case 
		when opts[:type] == 'Badge'
			prefix = 'get'
		  path = badge_badge_customize_url(badge)
		when is_location?(:controller => 'landing')
		  prefix = 'get'
		   path = badge_badge_customize_url(badge.badge)
		when badge.new_record?
			prefix = 'edit'
			 path = badge_badge_customize_url(badge.badge)
		when opts[:type] == 'MyBadge'
			prefix = 'edit'
			path = user_my_badge_customize_url(badge)
		end
		link_to(image_tag("icons/navigation/#{prefix}_badge.png", :alt => "#{prefix.capitalize} Badge"), path)
  end
  
  def save_link(badge, opts = {})
  	opts[:type] ||= badge.class.to_s
  	if badge.new_record?
  		link_to(image_tag('icons/navigation/save_badge.png', :alt => 'Save Badge'), url_for(:controller => 'user/my_badges', :action => 'new', :badge_id => badge.id ))
		else
			link_to(image_tag('icons/navigation/save_badge.png', :alt => 'Save Badge'), url_for(:controller => 'user/customize', :action => 'save', :my_badge_id => badge.id ))
		end
  end
  
  def get_badge_path(badge)
    case 
    when badge.class == Badge
      badge_path(badge)
    when badge.new_record? && !is_location?(:action => 'show')
      badge_path(badge.badge)
    when badge.class == MyBadge && is_location?(:controller => 'landing')
      badge_path(badge.badge)
    when badge.class == MyBadge
      user_my_badge_path(badge)
    end
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
	
	def badge_list(badges, size)
		render :partial => 'shared/badge_list', :locals => {:badges => badges, :size => size}
	end
	
	def extra_cells(expected, given)
	  if expected == given
      diff = expected - (given % expected)
      html = ''
      diff.times do 
        html << '<td>&nbsp;</td>'
      end
    end
    return html
	end
	
	
	def check_badge_type(badge)
		return badge.class.to_s
	end

  def featured_options
    [ ['Yes', 1] , ['No', 0] ]
  end

end
