class ConfirmationsController < Devise::ConfirmationsController
  # POST /resource/confirmation
  def create
    self.resource = resource_class.send_confirmation_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      render json: { message: I18n.t('controllers.confirmations.resent') }, status: 200
    else
      render json: resource.errors, status: 401
    end
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      render json: { message: I18n.t('controllers.confirmations.success') }, status: 200
    else
      render json: resource.errors, status: 401
    end
  end
end
