require 'rails_helper'

RSpec.describe "api/v1/posts", type: :request do
  context "index" do
    it 'Returns a status of 200 with a list of posts' do
      user = create_user
      create_post({ user: user })
      create_post({ user: user })
      get '/api/v1/posts'
      parsed = JSON.parse(response.body, object_class: OpenStruct)
      expect(response).to have_http_status(200)
      expect(parsed.data.size).to eq(2)
    end
  end
end
