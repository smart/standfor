class SassTemplateHandler
  include ERB::Util
  def initialize(view)
    @view = view
  end
  
  def render(template, local_assigns={})
    @view.controller.response.content_type = 'text/css'
    @view.instance_eval do
      evaluate_assigns
    end
    erbsrc = ERB.new(template, nil, '-').src
    erboutput = @view.instance_eval(erbsrc)
    Sass::Engine.new(erboutput).render
  end
end

ActionView::Base.register_template_handler 'sass', SassTemplateHandler