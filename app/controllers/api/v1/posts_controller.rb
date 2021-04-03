class Api::V1::PostsController < ApplicationController
  # GET /api/v1/posts
  def index
    render json: { data: Post.all }
  end
end
