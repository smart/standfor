module SegmentSystem

  def segment_required
    begin
      @segment ||= load_segment
      @organization ||= @segment.organization
      return true
    rescue 
      no_segment
    end

  end
  
  def load_segment
    begin
      segment_id = params[:segment_id] || session[:segment_id]
      segment = Segment.find(segment_id)
    rescue
      no_segment
    end
    return segment
  end 
  
  def load_organization 
    begin
      org_id =  params[:organization_id] || session[:organization_id]
      organization = Organization.find(org_id)
    rescue
      return false
    end
    return organization
  end
  
  def no_segment
    begin
      @organization ||= load_organization
      redirect_to organizations_url(@organization)
      return false
    rescue
      no_org
    end
  end
  
  def no_org
    redirect_to "/"
    return false
  end

end