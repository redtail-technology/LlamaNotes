class Api::V1::NotificationsController < Api::V1::BaseController
  def show
    respond_to do |format|
      format.json { render :json => { data: "" } }
    end
  end

  def index
    respond_to do |format|
      format.json { render json: current_user.notifications
                                             .order(created_at: :desc),
                           methods: [:icon_url, :company_name,
                                     :hour_created_at] }
    end
  end

  def create
    # Notification.new(:)
    respond_to do |format|
      format.json {
        render nothing: true, status: 200
        # respond_with(nil, :layout => false, :status => :unprocessable_entity) and return
      }
    end
  end


end
