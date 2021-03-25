require 'rails_helper'

RSpec.describe "api/v1/users", type: :request do
  context "available" do
    it 'Returns a status of 200 with no params' do
      get '/api/v1/users/available'
      parsed = JSON.parse(response.body, object_class: OpenStruct)
      expect(response).to have_http_status(200)
      expect(parsed.data).to eq(true)
    end

    it 'Returns false if username already exists' do
      create_user(name: 'testtest')
      get '/api/v1/users/available?username=testtest'
      parsed = JSON.parse(response.body, object_class: OpenStruct)
      expect(response).to have_http_status(200)
      expect(parsed.data).to eq(false)
    end

    it 'Returns true if username does not already exist' do
      create_user(name: 'testtest')
      get '/api/v1/users/available?username=testtest2'
      parsed = JSON.parse(response.body, object_class: OpenStruct)
      expect(response).to have_http_status(200)
      expect(parsed.data).to eq(true)
    end

    it 'Returns false if email already exists' do
      create_user(name: 'testtest')
      get '/api/v1/users/available?email=testtest@test.com'
      parsed = JSON.parse(response.body, object_class: OpenStruct)
      expect(response).to have_http_status(200)
      expect(parsed.data).to eq(false)
    end

    it 'Returns true if email does not already exist' do
      create_user(name: 'testtest')
      get '/api/v1/users/available?email=testtest2@test.com'
      parsed = JSON.parse(response.body, object_class: OpenStruct)
      expect(response).to have_http_status(200)
      expect(parsed.data).to eq(true)
    end
  end

  context "update" do
    it 'Requires a user' do
      user = create_user
      put "/api/v1/users/#{user.id}"
      expect(response).to have_http_status(401)
    end

    it 'Updates for the current user' do
      user = create_user
      headers = get_headers(user.username)
      put "/api/v1/users/#{user.id}",
        params: '{ "user": { "display_name": "hello" } }',
        headers: headers
      parsed = JSON.parse(response.body, object_class: OpenStruct)
      expect(response).to have_http_status(200)
      expect(parsed.user.displayName).to eq("hello")
    end

    it 'Does not update for another user' do
      user = create_user
      user2 = create_user
      headers = get_headers(user2.username)
      put "/api/v1/users/#{user.id}",
        params: '{ "user": { "display_name": "hello" } }',
        headers: headers
      parsed = JSON.parse(response.body, object_class: OpenStruct)
      expect(response).to have_http_status(200)
      expect(parsed.user.display_name).not_to eq("hello")
    end

    it 'Throws a 500 if error' do
      user = create_user
      headers = get_headers(user.username)
      put "/api/v1/users/#{user.id}",
        params: '{ "user123": { "display_name": "hello" } }',
        headers: headers
      expect(response).to have_http_status(500)
    end
  end
end
