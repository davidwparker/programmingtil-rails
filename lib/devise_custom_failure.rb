# https://github.com/heartcombo/devise/blob/master/lib/devise/failure_app.rb
class DeviseCustomFailure < Devise::FailureApp
  def respond
    # If fails on certain actions, then ignore and make request as if no user.
    # Basically, any with `authenticate_user_if_needed!` needs to use this as a fallback
    path_params = request.path_parameters
    control = path_params[:controller]
    act = path_params[:action]
    if (control == 'api/v1/ping' && act == 'index')
      # HACK! Rails converts 'api/v1/people'.classify => API::V1::Person
      # So we pluralize it and get People or Talks, etc
      classify = control.classify.pluralize

      warden_options[:recall] = "#{classify}##{act}"
      request.headers['auth_failure'] = true
      request.headers['auth_failure_message'] = i18n_message
      recall
    else
      http_auth
    end
  end

  # Override failure to always return JSON.
  # This is needed because Devise will attempt to redirect otherwise
  def http_auth_body
    {
      authFailure: true,
      error: i18n_message,
    }.to_json
  end
end
