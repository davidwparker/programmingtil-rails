class PingController < ApplicationController
  before_action :authenticate_user!, only: [:auth]

  # GET /ping
  def index
    render body: nil, status: 200
  end

  # GET /ping/auth
  def auth
    render body: nil, status: 200
  end
end
