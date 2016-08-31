module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg, class: "list-group-item list-group-item-danger") }.join

    html = <<-HTML
    <div class="panel panel-danger">
      <div class="panel-heading">Error</div>

      <ul class="list-group">
        #{messages}
      </ul>
    </div>
    HTML

    html.html_safe
  end
end
