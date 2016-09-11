class AddIconColumnToUsers < ActiveRecord::Migration[5.0]
  def up
    add_attachment :users, :icon
  end

  def down
    remove_attachment :users, :icon
  end
end
