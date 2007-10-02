module SponsorshipsHelper
  def sponsorship_checkbox(sponsorable, checked = {} )
     is_checked = (!checked[sponsorable.class.to_s].nil? and !checked[sponsorable.class.to_s][sponsorable.id].nil? ) ? ' checked ' : ''
     "<input #{is_checked} type=\"checkbox\" name=\"sponsorable[#{sponsorable.class.to_s}][#{sponsorable.id}]\" value=\"1\" >"
  end
end
