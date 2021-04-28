class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]

  # POST /api/v1/comments
  def create
    authorize Comment
    comment = Comment.create_comment!(current_user, create_params)
    render json: comment_show(comment, { message: I18n.t('controllers.comments.created') })
  end

  # DELETE /api/v1/comments/:id
  def destroy
    comment = Comment.find(params[:id])
    authorize comment
    comment = Comment.delete_comment!(comment)
    render json: comment_show(comment, { message: I18n.t('controllers.comments.deleted') })
  end

  # GET /api/v1/comments
  def index
    comments = policy_scope(Comment)
    comments = comments
      .where(commentable_id: params[:commentable_id], commentable_type: params[:commentable_type])
      .includes(:commentable, :user)
    render json: CommentIndexSerializer.new(comments, list_options).serializable_hash.to_json
  end

  # GET /api/v1/comments/:id
  def show
    comment = Comment.find(params[:id])
    render json: comment_show(comment)
  rescue ActiveRecord::RecordNotFound
    render json: { error: I18n.t('api.not_found') }, status: 404
  end

  # PUT /api/v1/comments/:id
  def update
    comment = Comment.find(params[:id])
    authorize comment
    comment = Comment.update_comment!(comment, update_params)
    render json: comment_show(comment, { message: I18n.t('controllers.comments.updated') })
  end

  private

  def create_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end

  def update_params
    params.require(:comment).permit(:body, :id, :commentable_id, :commentable_type)
  end

  def comment_show(comment, meta = {})
    CommentShowSerializer.new(comment, show_options(meta)).serializable_hash.to_json
  end
end
