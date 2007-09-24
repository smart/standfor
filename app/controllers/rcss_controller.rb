class RcssController < ApplicationController
  caches_page :rcss
  layout nil
  def rcss
    p "===Style Info==="
    p @style_info
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
