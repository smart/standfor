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
  
  
end
