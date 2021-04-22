class PasswordsController < Devise::PasswordsController
  respond_to :json

  # POST /users/password
  # Specs No
  def create
    if params[:user] && params[:user][:email].blank?
      render json: { error: I18n.t('controllers.passwords.email_required') }, status: 406
    else
      self.resource = resource_class.send_reset_password_instructions(resource_params)
      if successfully_sent?(resource)
        render json: { message: I18n.t('controllers.passwords.email_sent') }
      else
        respond_with_error(resource)
      end
    end
  end

  # PUT /users/password
  # Specs No
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)

    if resource.errors.empty?
      if Devise.sign_in_after_reset_password
        resource.after_database_authentication
        sign_in(resource_name, resource)
        if user_signed_in?
          respond_with(resource)
        else
          respond_with_error(resource)
        end
      else
        respond_with(resource)
      end
    else
      set_minimum_password_length
      respond_with_error(resource)
    end
  end

  private

  def current_token
    # NOTE: this is technically nil at this point, and user still must login again
    request.env['warden-jwt_auth.token']
  end

  def respond_with(resource, _opts = {})
    render json: {
      message: I18n.t('controllers.passwords.success'),
      user: resource.for_display,
      jwt: current_token,
    }
  end

  def respond_with_error(resource)
    render json: resource.errors, status: 401
  end
end
