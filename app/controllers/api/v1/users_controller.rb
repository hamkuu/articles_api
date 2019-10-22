class Api::V1::UsersController < ApplicationController
  def index
    users = User.all.order('created_at ASC')

    render json: users
  end

  # POST api/v1/users
  def create
    new_user = User.new(user_params)

    render json: { status: new_user.save, errors: new_user.errors }
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
