class AuthenticationController < ApplicationController
  # Code taken from:
  # https://www.pluralsight.com/guides/token-based-authentication-with-ruby-on-rails-5-api
  
  skip_before_action :authenticate_request

  # POST /authenticate
  # Required Headers:
  #   Content-Type: application/json
  # Body Contents (JSON):
  #   username: username of the user
  #   password: password of the user
  # Returns (JSON):
  #   auth_token: the user's token if authentication successful
  def authenticate
    command = AuthenticateUser.call(params[:username], params[:password])

    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end
end
