class Api::V1::AuthenticationController < Api::V1::BaseController
  skip_before_action :set_current_user
  skip_before_action :check_credentials

  def create
    user = User.find_by_email params[:email] if params[:email].present? || nil

    if user && user.valid_password?(params[:password])
      render json: { token: user.fetch_auth_token! }, status: :ok
    else
      render json: {}, status: :unauthorized
    end
  end

  private

  def required_params_exist
    params[:email] && params[:password]
  end
end
