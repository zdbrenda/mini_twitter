module ApplicationHelper
    # Returns the full title on a page_page basis
    def full_title(page_title = '' )
        base_title = "Mini Twitter"
        if page_title.empty?
            base_title
        else
            page_title+ ' | '+base_title 
        end
    end
end
