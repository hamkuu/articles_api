class Api::V1::UsersController < ApplicationController
  before_action :basic_authenticate, only: [:generate_auth_token]
  before_action :token_authenticate, except: [:generate_auth_token, :create]

  def index
    users = User.all.order('created_at ASC')

    render json: users
  end

  # POST api/v1/users
  def create
    new_user = User.new(user_params)

    render json: { status: new_user.save, errors: new_user.errors }
  end

  def get_user_info
    render json: { status: @user.valid?, user_info: @user }
  end

  def generate_auth_token
    status = @user.regenerate_auth_token
    payload = { auth_token: @user.auth_token }
    auth_jwt = JsonWebToken.encode payload
    save_cookie_in_browser :auth_token, auth_jwt

    render json: { status: status, token: payload }
  end

  def revoke_auth_token
    remove_cookie_from_browser :auth_token

    render json: { status: true, message: 'auth_token has been revoked.' }
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def token_authenticate
    auth_jwt = cookies.signed[:auth_token]
    decoded_payload = JsonWebToken.decode auth_jwt
    decoded_auth_token = decoded_payload[0]['auth_token']

    @user = User.find_by(auth_token: decoded_auth_token)
    @user && decoded_auth_token == @user.auth_token
  end

  def basic_authenticate
    error_message = { status: false, message: 'basic authentication failed.' }.to_json

    authenticate_or_request_with_http_basic('', error_message) do |username, password|
      @user = User.find_by(email: username.downcase)
      @user&.authenticate(password)
    end

    # suppress login prompt from browser
    response.set_header('WWW-Authenticate', '')
  end
end
