module ApplicationHelper
	def markdown(text)
		if !text.blank?
	    redcarpet = Redcarpet::Markdown.new(Redcarpet::Render::HTML, 
										:space_after_headers => true,
										:fenced_code_blocks => true, 
										:autolink => true, 
										:no_intra_emphasis => false,
										:strikethrough => true, 
										:superscripts => true, 
										:tables => true, 
										:lax_html_blocks => true)
	  	redcarpet.render(text).html_safe
	  end
	end
	
	
end
