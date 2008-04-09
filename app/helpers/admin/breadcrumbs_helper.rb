module Admin::BreadcrumbsHelper
  #TODO: Refactor to support alternate route contexts
  def breadcrumbs
    
    html = [link_to('Admin', admin_home_path)]
    
    #first level
    html << link_to('Organizations', admin_organizations_path) if @organizations || @organization
    html << link_to(@organization.name, admin_organization_path(@organization)) if @organization
    
    #second level
    html << link_to('Segments', admin_organization_segments_path(@organization)) if @segments || @segment
    html << link_to(@segment.name, admin_organization_segment_path(@organization, @segment)) if @segment
    
    #third level
    html << link_to('Badges', admin_organization_segment_badges_path(@organization, @segment)) if @badges || @badge
    html << link_to(@badge.name, admin_organization_segment_badge_path(@organization, @segment, @badge)) if @badge
    
    html.join('&gt;')
  end
end