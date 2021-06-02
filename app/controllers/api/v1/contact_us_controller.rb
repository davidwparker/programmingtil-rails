class Api::V1::ContactUsController < ApplicationController
  # POST /api/v1/contact_us
  def create
    cu = ContactUs.new(contact_us_params)
    if cu.save
      render json: { message: I18n.t('controllers.contact_us.success') }
    else
      render json: { error: I18n.t('api.oops') }, status: 401
    end
  end

  private

  def contact_us_params
    params.require(:contact).permit(:email, :body, :name)
  end
end
