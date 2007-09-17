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

  def content_box(header_text, opts = {}, &block)
    concat("<div " + (opts[:id] ? "id=\"#{opts[:id]}\" " : "") + "class=\"" + (opts[:class] ? "#{opts[:class]} box\"" : "default box\"") +">", block.binding )   
    concat("<div class=\"content\">", block.binding)
    concat("  <div class=\"t\"></div>", block.binding)
    concat("  <h1>#{header_text}</h1>", block.binding)
    yield
    concat("</div>", block.binding)
    concat("<div class=\"b\"><div></div></div>", block.binding)
    concat("</div>", block.binding)
  end
  
  def button(opts = {})
    image = image_tag(opts[:image], :alt => opts[:alt])
    link = opts[:link]
    html = content_tag(:span, link_to(image, link), :class => opts[:class])
    return html
  end
  
#  def markaby(&proc)
#    assigns = {}
#      instance_variables.each do |name|
#        assigns[ name[1..-1] ] =  instance_variable_get(name)
#      end
#    Markaby::Builder.new(assigns, self).capture(&proc)
#  end
#  
#  def tasks(&block)
#    markaby do
#      div.tasks {
#        ul {
#          markaby(&block)
#        }
#      }
#    end
#  end
#  
#  def contenter()
#    tasks do
#      task
#    end
#  end
#  
#  def task 
#    return "hi there"
#  end
  

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
  
end
