module ObjectCreators
  def create_allowlisted_jwts(params = {})
    user = params[:user].presence || create_user
    user.allowlisted_jwts.create!(
      jti: params['jti'].presence || 'TEST',
      aud: params['aud'].presence || 'TEST',
      exp: Time.at(params['exp'].presence.to_i || Time.now.to_i)
    )
  end

  def create_user(params = {})
    last_id = User.limit(1).order(id: :desc).pluck(:id).first || 0
    user = User.new(
      email: params[:name].present? ? "#{params[:name]}@test.com" : "testtest#{last_id+1}@test.com",
      username: params[:name].present? ? "#{params[:name]}" : "testtest#{last_id+1}",
      password: 'testtest',
      password_confirmation: 'testtest'
    )
    user.skip_confirmation!
    user.save!
    user
  end

  # CONVENIENCE methods
  def get_headers(login)
    jwt = get_jwt(login)
    {
      "Accept": "application/json",
      "Content-Type": "application/json",
      'HTTP_JWT_AUD': 'test',
      'Authorization': "Bearer #{jwt}"
    }
  end

  def get_jwt(login)
    # NOTE: RSPEC sucks (uses HTTP_ because WTF)
    headers = { 'HTTP_JWT_AUD': 'test' }
    post '/users/sign_in', params: { user: { login: login, password: 'testtest' } }, headers: headers
    JSON.parse(response.body, object_class: OpenStruct).jwt
  end
end

RSpec.configure do |config|
  config.include ObjectCreators
end
