class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :smart_back_path

  def smart_back_path(fallback = entities_path)
    request.referer.presence || fallback
  end

end
