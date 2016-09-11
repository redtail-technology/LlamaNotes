class Api::V1::BaseController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  before_action :set_current_user, except: 'cor'
  before_action :check_credentials, except: 'cor'
  before_action :cors_preflight_check
  after_action :cors_set_access_control_headers

  respond_to :json

  def cor
      render text: '', content_type: 'text/plain'
  end

  private

  def set_current_user
    sign_in User.find_by auth_token: request.env["HTTP_AUTHORIZATION"] unless current_user
  end

  def check_credentials
    render status: :unauthorized unless current_user
  end

  def cors_preflight_check
    if request.method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
      headers['Access-Control-Max-Age'] = '1728000'
    end
  end

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
    headers['Access-Control-Max-Age'] = "1728000"
  end
end
