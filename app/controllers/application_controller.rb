class ApplicationController < ActionController::Base
  rescue_from ActionController::UnpermittedParameters,
              with: :catch_unpermitted_parameters

  def render_404
    render json: { message: 'page not found' }, status: 404
  end

  def catch_unpermitted_parameters
    render json: { message: $ERROR_INFO.message }, status: :unprocessable_entity
  end
end
