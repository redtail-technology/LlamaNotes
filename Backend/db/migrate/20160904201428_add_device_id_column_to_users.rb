class AddDeviceIdColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :devise_id, :string
  end
end
