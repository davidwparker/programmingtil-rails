class ApplicationController < ActionController::API
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :configure_permitted_parameters, if: :devise_controller?

  # Helper methods
  # Return an options object for lists for jsonapi-serializer
  def list_options(meta = {})
    opts = { is_collection: true }
    opts[:meta] = get_meta_data(meta)
    opts[:params] = get_params_data
    opts
  end

  # Return an options object for single objects for jsonapi-serializer
  def show_options(meta = {})
    opts = { is_collection: false }
    opts[:meta] = get_meta_data(meta)
    opts[:params] = get_params_data
    opts
  end

  # Set any kind of meta data needed for the options
  def get_meta_data(meta = {})
    ret_meta = meta
    if request.headers['auth_failure']
      ret_meta[:authFailure] = true
    else
      if current_token.present?
        ret_meta[:jwt] = current_token
      end
    end
    ret_meta
  end

  # Set any kind of params data needed for the options
  def get_params_data
    if current_user.present?
      { user: current_user, }
    else
      {}
    end
  end

  protected

  def current_token
    request.env['warden-jwt_auth.token']
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email])
  end

  private

  def user_not_authorized
    render json: { message: I18n.t('api.unauthorized') }, status: 404
    return
  end
end
