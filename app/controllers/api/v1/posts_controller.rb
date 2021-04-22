class Api::V1::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]

  # POST /api/v1/posts
  def create
    authorize Post
    post = Post.create_post!(create_params, current_user)
    render json: post_show(post, { message: I18n.t('controllers.posts.created') })
  end

  # DELETE /api/v1/posts/:id
  def destroy
    post = Post.find(params[:id])
    authorize post
    post = Post.delete_post!(post)
    render json: post_show(post, { message: I18n.t('controllers.posts.deleted') })
  end

  # GET /api/v1/posts
  def index
    posts = policy_scope(Post)
    posts = posts.includes(:user)
    render json: PostIndexSerializer.new(posts, list_options).serializable_hash.to_json
  end

  # GET /api/v1/posts/:slug
  def show
    post = Post.friendly.find(params[:id])
    render json: post_show(post)
  rescue ActiveRecord::RecordNotFound
    render json: { error: I18n.t('api.not_found') }, status: 404
  end

  # PUT /api/v1/posts/:id
  def update
    post = Post.find(params[:id])
    authorize post
    post = Post.update_post!(post, update_params)
    render json: post_show(post, { message: I18n.t('controllers.posts.updated') })
  end

  private

  def create_params
    params.require(:post).permit(:title, :content, :published_at)
  end

  def update_params
    params.require(:post).permit(:id, :title, :content, :published_at)
  end

  def post_show(post, meta = {})
    PostShowSerializer.new(post, show_options(meta)).serializable_hash.to_json
  end
end
