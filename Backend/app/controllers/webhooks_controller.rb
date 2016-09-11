class WebhooksController < ApplicationController
  respond_to :js

  def create
    @webhook = Webhook.create!(webhook_params.merge(user_id: current_user.id))
  end

  def show
    @token = params[:token]
  end

  private

  def webhook_params
    params.permit(:company_id)
  end
end
