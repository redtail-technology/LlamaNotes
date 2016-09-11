class ChangeDeviceIdColumnOnUsers < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :devise_id, :device_id
  end
end
