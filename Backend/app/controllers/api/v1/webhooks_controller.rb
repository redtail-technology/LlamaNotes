class Api::V1::WebhooksController < Api::V1::BaseController
  def receive
    webhook = Webhook.find_by_token(params[:token])

    notification = Notification.create!(user_id: current_user.id,
                                        company_id: webhook.company_id,
                                        message: params[:message])

    response = IonicService.push(notification, webhook.user.device_id)

    if response.kind_of?(Net::HTTPSuccess)
      flash[:notice] = 'Message successfully sent'
    else
      flash[:notice] = 'Message not successfully sent'
    end

    respond_to do |format|
      format.json { head :ok }
      format.js { }
      format.html { head :ok }
    end
  end
end
