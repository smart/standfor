# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

#  def new_box(&block)
#    b = markaby do 
#      div.default.box do
#        h2 "Testing Markaby Helper"
#        p "testing"
#        capture(&block)
#      end
#    end
#    concat b.to_s, block.binding
#  end
#  
#  def markaby(&block)
#    Markaby::Builder.new({}, self, &block)
#  end

  def old_content_box(header_text, opts = {}, &block)
  	escaped_text = CGI.escape(header_text)
  	#image_path = "/text/header_text/#{escaped_text}.png"
		#image_path = "/text/basicborder_header/#{escaped_text}.png" if (opts[:class] == 'basicborder' || opts[:class] == 'basic' )
		#image_path = "/text/header_text/#{escaped_text}.png?color=black" if (opts[:class] == 'light' )
  	#header_image = image_tag("#{image_path}", :alt => header_text)
    concat("<div " + (opts[:id] ? "id=\"#{opts[:id]}\" " : "") + "class=\"" + (opts[:class] ? "#{opts[:class]} box\"" : "default box\"") +">", block.binding )   
    concat("<div class=\"content\">", block.binding)
    concat("  <div class=\"t\"></div>", block.binding)
    concat("  <h1>#{header_text}</h1>", block.binding) if !header_text.empty?
    yield
    concat("</div>", block.binding)
    concat("<div class=\"b\"><div></div></div>", block.binding)
    concat("</div>", block.binding)
  end
  
  def content_box(opts = {}, &block)
    internal_id = opts[:internal_id] ? "id=\"#{opts[:internal_id]}\" " : nil
    external_id = opts[:external_id] ? "id=\"#{opts[:external_id]}\" " : nil
    box_class = opts[:box_class] ? opts[:box_class] + " round box" : "round box"
    
    opts = opts.merge(:box_class => box_class, :external_id => external_id, :internal_id => internal_id)
    
    block_to_partial 'shared/patterns/roundbox', opts, &block
  end
  
  def grey_fade(opts = {}, &block)
    box_class = opts[:class] ? "grey-fade #{opts[:class]}" : "grey-fade"
    box_id = opts[:id] || nil
    
    block_to_partial 'shared/patterns/grey_fade', opts.merge(:box_class => box_class, :box_id => box_id), &block
  end
  
  def trans_image_tag(image, width, height, opts = {})
    opts.merge!(:src => "/images/#{image}", :width => width, :height => height)
    content_tag(:img, nil, opts)
  end
  
  def old_grey_fade(opts = {}, &block)
  	box_class = opts[:class] ? "grey-fade #{opts[:class]}" : "grey-fade"
  	box_id = opts[:id] || nil
  	#header_text = opts[:header] || nil
  	
  	html = '<div class="end-cap"></div>'
  	#html << content_tag(:h2, header_text) if header_text
  	html << capture(&block)
  	html = content_tag(:div, html, :class => box_class, :id => box_id)
  	
  	concat(html, block.binding)
  end
  
  def radial_box(opts = {}, &block)
    box_class  = opts[:class] ? "radial #{opts[:class]}" : "radial"
    box_id = opts[:id] || nil
    
    block_to_partial 'shared/patterns/radial_box', opts.merge(:box_class => box_class, :box_id => box_id), &block
  end
  
  def old_radial_box(opts = {}, &block)
  	box_class = opts[:class] ? "radial #{opts[:class]}" : "radial"
  	box_id = opts[:id] || nil
  	
  	html = content_tag(:div, capture(&block), :class => 'inner-wrapper')
  	html = content_tag(:div, html, :class => box_class, :id => box_id)
  	
  	concat(html, block.binding)
  	
  end
  
  def button(opts = {})
    image = image_tag(opts[:image], :alt => opts[:alt])
    link = opts[:link] ? opts[:link] : "document.getElementById('#{opts[:form_id]}').submit()"
    if opts[:type] == "submit"
      html = content_tag(:span, link_to_function(image, link), :class => opts[:class])
    elsif opts[:type] == "remote_submit"
     @form = opts[:form_id] 
     @url = opts[:url] 
      link = remote_function(:url => @url , :with => "Form.serialize('#{@form}')" )
      html = content_tag(:span, link_to_function(image, link), :class => opts[:class])
    else
     html = content_tag(:span, link_to(image, link), :class => opts[:class])
    end
    return html
  end
  
  def form_button(img, alt, opts = {})
  	image = image_tag(img, :alt => alt)
  	type = opts[:type] ? opts[:type] : 'submit'
		html = content_tag(:button, :type => type, :class => 'replace-button') do
			content_tag(:span, link_to(image, ""), :class => 'large-button' )
		end
	
  end
  
  def current_segment?(segment, current)
		html = ''
		html = 'current' if current == segment
		return html
	end

   def  current_donation_value(order , segment)
      return 0 if order.nil?
      order.donations.each do |donation| 
         return donation.amount if donation.segment.id == segment.id
      end
      return 0
   end 
   
	def format_price(price)
  	price.zero? ? "No donation" : number_to_currency((price.to_f), :precision => 2 )
	end


  def select_state_for_account
       [["","Select State..."], ["AL","Alabama"],
        ["AK","Alaska"], ["AZ","Arizona"], ["AR","Arkansas"],
        ["CA","California"], ["CO","Colorado"], ["CT","Connecticut"],
        ["DE","Delaware"], ["DC","District of Columbia"], ["FL","Florida"],
        ["GA","Georgia"], ["HI","Hawaii"], ["ID","Idaho"], ["IL","Illinois"],
        ["IN","Indiana"], ["IA","Iowa"], ["KS","Kansas"], ["KY","Kentucky"],
        ["LA","Louisiana"], ["ME","Maine"], ["MD","Maryland"],
        ["MA","Massachusetts"], ["MI","Michigan"], ["MN","Minnesota"],
        ["MS","Mississippi"], ["MO","Missouri"], ["MT","Montana"],
        ["NE","Nebraska"], ["NV","Nevada"], ["NH","New Hampshire"],
        ["NJ","New Jersey"], ["NM","New Mexico"], ["NY","New York"],
        ["NC","North Carolina"], ["ND","North Dakota"], ["OH","Ohio"], ["OK","Oklahoma"],
        ["OR","Oregon"], ["PA","Pennsylvania"], ["RI","Rhode Island"],
        ["SC","South Carolina"], ["SD","South Dakota"],
        ["TN","Tennessee"], ["TX","Texas"], ["UT","Utah"], ["VT","Vermont"],
        ["VA","Virginia"], ["WA","Washington"], ["WV","West Virginia"],
        ["WI","Wisconsin"], ["WY","Wyoming"]]
	end
	
	def is_location?(opts = {})
		opts[:controller] ||= controller.controller_name
		opts[:action] ||= controller.action_name
		#return controller.action_name
		if is_controller?(opts[:controller]) and is_action?(opts[:action])
			true
		else
			false
		end
	end
	
	def is_controller?(expected_controller)
		expected_controller == controller.controller_name
	end
	
	def is_action?(expected_action)
		expected_action == controller.action_name
	end
	
	def is_id?(expected_id)
	  expected_id == params[:id]
	end
	
end
  
