module Worldreach::SegmentsHelper
	
	def segment_select?(segment, current)
		if current == segment
			html = ' class="selected"'
		else
			html = ''
		end
		return html
	end
end
