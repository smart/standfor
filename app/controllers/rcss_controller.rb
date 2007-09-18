class RcssController < ApplicationController
  caches_page :rcss
  layout nil
  def rcss
    #params[:styled_id]
    #@styled = StyleSetting.find(params[:styled_id])
    #@color1 = @styled.color1
    #@color2 = @styled.color2
    #@color3 = @styled.color3
    #@styled_id = @styled.id.to_s
    # :rcssfile is defined in routes.rb
    #p params[:rcss]
    if @stylefile = params[:rcss]
      #prep stylefile with relative path and correct extension
      @stylefile.gsub!(/.css$/, '')
      @stylefile = "/rcss/" + @stylefile + ".rcss"
      render(:file => @stylefile, :use_full_path => true, :content_type => "text/css")
    else #no method/action specified
      render(:nothing => true, :status => 404)
    end #if @stylefile..
  end #rcss
end
