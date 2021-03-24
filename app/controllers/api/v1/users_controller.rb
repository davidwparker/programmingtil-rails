class Api::V1::UsersController < ApplicationController
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
end
