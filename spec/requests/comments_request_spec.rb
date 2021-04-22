require 'rails_helper'

RSpec.describe "api/v1/comments", type: :request do
  # Index
  context 'GET /api/v1/comments' do
    it 'Returns a status of 200 with a list of posts' do
      user = create_user
      post = create_post({ user: user })
      create_comment({ user: user, commentable: post })
      create_comment({ user: user, commentable: post })
      create_comment({ user: user, commentable: post })
      get "/api/v1/comments?commentable_id=#{post.id}&commentable_type=Post"
      parsed = JSON.parse(response.body, object_class: OpenStruct)
      expect(response).to have_http_status(200)
      expect(parsed.data.size).to eq(3)
    end
  end
end
