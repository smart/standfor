module NestedLayoutsHelper
  
  def view_layout(sub_layout)
    if !sub_layout.nil?
      "shared/#{sub_layout}"
    elsif File.exists?(File.join(RAILS_ROOT, 'app', 'views', 'layouts', controller.controller_name, "_#{controller.action_name}.html.erb"))
      "#{controller.controller_name}/#{controller.action_name}"
    else
      "shared/blank"
    end
  end
  
  def controller_layout
    if !controller_namespace.nil?
      if File.exists?(File.join(RAILS_ROOT, 'app', 'views', 'layouts', controller_namespace, "_#{controller.controller_name}.html.erb"))
        "#{controller_namespace}/#{controller.controller_name}.html.erb"
      else
        "shared/blank"
      end
    elsif File.exists?(File.join(RAILS_ROOT, 'app', 'views', 'layouts', "_#{controller.controller_name}.html.erb"))
      "_#{controller.controller_name}.html.erb"
    else
      "shared/blank"
    end
  end
  
  def action_layout
    File.exists?(File.join(RAILS_ROOT, 'app', 'views', 'layouts', controller.controller_name, "_#{controller.action_name}.html.erb"))
  end
  
  def presentation_layout(sub_layout)
    if !sub_layout.nil?
      %Q[id="#{sub_layout}" ]
    else
      %Q[id="sub_layout" ]
    end
  end
  
  def controller_namespace
    path_items = params[:controller].split("/")
    path_items.length > 1 ? path_items.first : nil
  end
  
  def inherit_view(options = {}, &block)
    # We accept a shorthand syntax -- if options is a string, render as a file.
    return inherit_view({:file => options}, &block) if options.is_a?(String)

    bind = options[:binding]

    # Get our differences and additions to the view we're inheriting.
    if block_given?
      bind ||= block.binding
      instance_variable_set(:@content_for_layout, capture(&block)) 
    end

    raise "Important: inherit_view() requires a block. " +
      "An empty block (eg, using {}) is suitable." unless bind 

    # If we're inheriting a partial, lend our local context to that partial.
    options[:locals] = eval("local_assigns", bind) if options[:partial]

    # Render our parent view.
    concat(render(options), bind)
  end
  
end