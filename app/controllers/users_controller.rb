class UsersController < ApplicationController
  skip_before_action :authenticate_request

  # POST /register
  # Required Headers:
  #   Content-Type: application/json
  # Body Contents (JSON):
  #   user:
  #     username: self-explanatory
  #     password: self-explanatory
  #     password_confirmation: self-explanatory
  # Returns (JSON):
  #   User object if save is successful
  def create
    @user = User.new(user_params)
    if @user.save
      render json: { user: @user, success: 'User registration successful' }
    else
      render json: { error: 'User registration unsuccessful' }
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
end
