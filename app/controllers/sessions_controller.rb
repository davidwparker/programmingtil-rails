require 'digest'

class SessionsController < Devise::SessionsController
  respond_to :json

  # POST /users/sign_in
  # Specs No
  def create
    # Check both because rspec vs normal server requests .... do different things? WTF.
    possible_aud = request.headers['HTTP_JWT_AUD'].presence || request.headers['JWT_AUD'].presence
    if params[:browser].present?
      browser, version = params[:browser].split("||")
      digest = Digest::SHA256.hexdigest("#{params[:os]}||||#{browser}||#{version.to_i}")
      if digest != possible_aud
        raise "Unmatched AUD"
      end
    end
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    if user_signed_in?
      # TODO: resource.blocked?
      #
      # For the initial login, we need to manually update IP / metadata for JWT here as no hooks
      # And we'll want this data for all subsequent requests
      last = resource.allowlisted_jwts.where(aud: possible_aud).last
      aud = possible_aud
      if last.present?
        last.update_columns({
          browser_data: params[:browser],
          os_data: params[:os],
          remote_ip: params[:ip],
        })
        aud = last.aud
      end
      respond_with(resource, { aud: aud })
    else
      render json: resource.errors, status: 401
    end
  rescue => e
    render json: { error: I18n.t('api.oops') }, status: 500
  end

  private

  def current_token
    request.env['warden-jwt_auth.token']
  end

  # What we respond with for signing in.
  # Add token in with body as fetch+CORS cannot read Authorization header
  def respond_with(resource, opts = {})
    # NOTE: the current_token _should_ be the last AllowlistedJwt, but it might not
    # be, in case of race conditions and such
    render json: {
      user: resource.for_display,
      jwt: current_token,
      # aud: opts[:aud],
    }
  end

  # Required for sign out
  def respond_to_on_destroy
    render json: { message: I18n.t('controllers.sessions.sign_out') }
  end
end
