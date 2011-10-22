module ApplicationHelper
  
  def logo
    logo = image_tag("logo.png", :alt => "Misocure Logo", :class => "round")
  end
  # Return a title on a per-paage basis
  def title
    base_title = "Misocure"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
