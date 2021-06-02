module ObjectCreators
  def create_allowlisted_jwts(params = {})
    user = params[:user].presence || create_user
    user.allowlisted_jwts.create!(
      jti: params['jti'].presence || 'TEST',
      aud: params['aud'].presence || 'TEST',
      exp: Time.at(params['exp'].presence.to_i || Time.now.to_i)
    )
  end

  def create_comment(params = {})
    user = params[:user].presence || create_user
    commentable = params[:commentable].presence || create_post
    last_id = Comment.limit(1).order(id: :desc).pluck(:id).first || 0
    Comment.create_comment!(user, {
      body: params[:body].presence || "Comment #{last_id+1}",
      commentable_id: commentable.id,
      commentable_type: commentable.class.name,
    })
  end

  def create_contact_us(params = {})
    body = params[:body].presence || 'test body'
    email = params[:email].presence || 'test@test.com'
    name = params[:name].presence || 'tester'
    ContactUs.create!(body: body, email: email, name: name )
  end

  def create_post(params = {})
    user = params[:user].presence || create_user
    last_id = Post.limit(1).order(id: :desc).pluck(:id).first || 0
    Post.create!({
      title: params[:title].presence || "Post #{last_id+1}",
      content: params[:content].presence || "Post content #{last_id+1}",
      user_id: user.id
    })
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
  def get_aud
    Digest::SHA256.hexdigest("#{get_os}||||#{get_browser}")
  end

  def get_browser
    'Chrome||89'
  end

  def get_os
    'Linux||5.0'
  end

  def get_headers(login = nil)
    if login
      jwt = get_jwt(login)
      {
        "Accept": "application/json",
        "Content-Type": "application/json",
        'HTTP_JWT_AUD': get_aud,
        'Authorization': "Bearer #{jwt}"
      }
    else
      {
        "Accept": "application/json",
        "Content-Type": "application/json",
      }
    end
  end

  def get_jwt(login)
    # NOTE: RSPEC sucks (uses HTTP_ because WTF)
    headers = { 'HTTP_JWT_AUD': get_aud }
    post '/users/sign_in', params: {
      user: { login: login, password: 'testtest' },
      browser: get_browser,
      os: get_os
    }, headers: headers
    JSON.parse(response.body, object_class: OpenStruct).jwt
  end
end

RSpec.configure do |config|
  config.include ObjectCreators
end
