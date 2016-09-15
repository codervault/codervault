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

  def gravatar_url(user, size)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "https://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=mm"
  end
end
