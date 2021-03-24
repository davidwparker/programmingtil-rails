require 'rails_helper'

RSpec.describe "api/v1/users", type: :request do
  context "available" do
    it 'Returns a status of 200 with no params' do
      get '/api/v1/users/available'
      expect(response).to have_http_status(200)
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
end
