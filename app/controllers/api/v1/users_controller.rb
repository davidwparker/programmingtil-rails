class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:update]

  # GET /api/v1/users/available
  def available
    free = if params[:email].present?
      !User.where(email: params[:email].downcase).exists?
    elsif params[:username].present?
      !User.where(username: params[:username].downcase).exists?
    else
      true
    end
    render json: { data: free }
  end

  # GET /api/v1/users/#{slug}
  def show
    user = User.friendly.find(params[:id])
    render json: UserShowSerializer.new(user, show_options).serializable_hash.to_json
  rescue ActiveRecord::RecordNotFound
    render json: { error: I18n.t('api.not_found') }, status: 404
  end

  # authenticate_user!
  # PUT /api/v1/users/#{id}
  def update
    current_user.update(user_params)
    render json: {
      message: I18n.t('controllers.users.updated'),
      user: current_user.for_display
    }
  rescue => error
    render json: { error: I18n.t('api.oops') }, status: 500
  end

  private

  def user_params
    params.require(:user).permit(
      :display_name,
      :username
    )
  end
end
