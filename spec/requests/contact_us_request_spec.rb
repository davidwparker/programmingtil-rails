require 'rails_helper'

RSpec.describe "api/v1/contact_us", type: :request do
  # Create
  context 'POST /api/v1/contact_us' do
    it 'returns 200 with valid data' do
      url = '/api/v1/contact_us'
      post url,
        params: '{ "contact": { "body": "the body", "email": "test@Test.com", "name": "Poor Joe" } }',
        headers: get_headers
      parsed = JSON.parse(response.body, object_class: OpenStruct)
      expect(response).to have_http_status(200)
      expect(parsed.message).to eq("Message sent successfully.")
    end

    it 'returns 401 with invalid data' do
      url = '/api/v1/contact_us'
      post url,
        params: '{ "contact": { "body": "", "email": "test@Test.com", "name": "Poor Joe" } }',
        headers: get_headers
      parsed = JSON.parse(response.body, object_class: OpenStruct)
      expect(response).to have_http_status(401)
    end
  end
end
