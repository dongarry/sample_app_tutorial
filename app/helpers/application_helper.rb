module ApplicationHelper
	
	def logo
		# Default logo
		logo = image_tag("logo.png", :alt => "Sample App", :class => "round")
	end

	# return a title on a per-page basis
	def title
		base_title = "Ruby on Rails Tutorial Sample App"

		if @title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
		end
	end
end
