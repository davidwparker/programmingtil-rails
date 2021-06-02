require 'rails_helper'

RSpec.describe "api/v1/comments", type: :request do
  # Create
  context 'POST /api/v1/comments' do
    context 'without a user' do
      it 'returns a 401' do
        post '/api/v1/comments'
        expect(response).to have_http_status(401)
      end
    end

    context 'as a user' do
      it 'should let me create a comment on a post' do
        user = create_user
        post = create_post({ user: user })
        headers = get_headers(user.username)
        post '/api/v1/comments',
          params: '{ "comment": { "body": "comment body", "commentable_type": "Post", "commentable_id": ' + post.id.to_s + ' } }',
          headers: headers
        parsed = JSON.parse(response.body, object_class: OpenStruct)
        expect(response).to have_http_status(200)
        expect(parsed.data.attributes.user.id).to eq(user.id)
        expect(parsed.data.attributes.body).to eq('comment body')
      end
    end
  end

  # Destroy
  context 'DELETE /api/v1/comments/:id' do
    context 'without a user' do
      it 'returns a 401' do
        record = create_comment
        delete "/api/v1/comments/#{record.id}"
        expect(response).to have_http_status(401)
      end
    end

    context 'as a user' do
      it 'should not let me destroy an comment' do
        user = create_user
        user2 = create_user
        record = create_comment({ user: user })
        url = "/api/v1/comments/#{record.id}"
        delete url, headers: get_headers(user2.username)
        expect(response).to have_http_status(404)
      end
    end

    context 'as a user (owner)' do
      it 'should let me destroy a comment' do
        user = create_user
        record = create_comment({ user: user })
        url = "/api/v1/comments/#{record.id}"
        delete url, headers: get_headers(user.username)
        parsed = JSON.parse(response.body, object_class: OpenStruct)
        expect(response).to have_http_status(200)
        expect(parsed.data.attributes.user).to eq(nil)
        expect(parsed.data.attributes.body).to eq('[deleted]')
      end
    end
  end

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


  # Show
  context 'GET /api/v1/comments/:slug' do
    it 'Returns a status of 404 if does not exist' do
      get '/api/v1/comments/1234'
      parsed = JSON.parse(response.body, object_class: OpenStruct)
      expect(response).to have_http_status(404)
    end

    it 'Returns a comment if exists' do
      user = create_user(name: 'testtest')
      record = create_comment({ user: user })
      get "/api/v1/comments/#{record.id}"
      parsed = JSON.parse(response.body, object_class: OpenStruct)
      expect(response).to have_http_status(200)
      expect(parsed.data.id.to_i).to eq(record.id)
    end
  end

  # Update
  context 'PUT /api/v1/comments/:id' do
    context 'without a user' do
      it 'returns a 401' do
        record = create_comment
        url = "/api/v1/comments/#{record.id}"
        put url, params: '{ "comment": { "body": "comment updated 1" } }'
        expect(response).to have_http_status(401)
      end
    end

    context 'as a non-user of comment' do
      it 'should not let me update a comment' do
        user = create_user
        user2 = create_user
        record = create_comment({ user: user })
        headers = get_headers(user2.username)
        url = "/api/v1/comments/#{record.id}"
        put url, params: '{ "comment": { "title": "comment updated 1" } }', headers: headers
        expect(response).to have_http_status(404)
      end
    end

    context 'as a comment owner' do
      it 'should let me update a comment' do
        user = create_user
        record = create_comment({ user: user })
        headers = get_headers(user.username)
        url = "/api/v1/comments/#{record.id}"
        put url, params: '{ "comment": { "body": "comment updated 1" } }', headers: headers
        parsed = JSON.parse(response.body, object_class: OpenStruct)
        expect(response).to have_http_status(200)
        expect(parsed.data.attributes.body).to eq('comment updated 1')
      end
    end
  end
end
