module ApplicationHelper
  def validation_feedback(object, field)
    message = object.errors.full_messages_for(field).first
    content_tag(:div, message, class: "invalid-feedback d-block") if message
  end
end
