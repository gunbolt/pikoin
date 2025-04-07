Rails.application.config.action_view.field_error_proc = proc do |html_tag, _|
  html_tag.html_safe
end
