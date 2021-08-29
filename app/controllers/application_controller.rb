class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  private

  def render_not_found_response exception
    render file: "#{Rails.root}/public/404.html", status: :not_found#404
  end
end
