class SessionsController < ApplicationController
  def create
    @response = Faraday.post("https://github.com/login/oauth/access_token?client_id=#{Figaro.env.client_id}&client_secret=#{Figaro.env.client_secret}&code=#{params['code']}")
    token = @response.body.split(/\W+/)[1]

    oauth_response = Faraday.get("https://api.github.com/user?access_token=#{token}")
    oauth = JSON.parse(oauth_response.body)

    user = User.find_or_create_by(uid: oauth["id"])
    user.username = oauth["login"]
    user.token = token
    user.save

    session[:user_id] = user.id

    redirect_to dashboard_index_path
  end
end
