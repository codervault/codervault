module ApplicationHelper

  def active_class(link_path)
    current_page?(link_path) ? "active" : ""
  end

  def flash_to_class(key)
    flash_class = case key
      when "success" then "success"
      when "notice" then "success"
      when "alert" then "danger"
      when "error" then "danger"
      else "info"
    end
  end
end
