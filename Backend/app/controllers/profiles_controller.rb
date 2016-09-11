class ProfilesController < ApplicationController
  def show
    @device_id = current_user.device_id
  end

  def update
    user = User.find_by_id(current_user.id)
    if user.update_attributes(profile_params)
      flash.now[:notice] = "Settings successfully saved"
    else
      flash.now[:notice] = "Settings could not be saved"
    end
  end

  private

  def profile_params
    params.permit(:device_id)
  end
end
