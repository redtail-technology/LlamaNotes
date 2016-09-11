class CreateWebhooks < ActiveRecord::Migration[5.0]
  def change
    create_table :webhooks do |t|
      t.string :token
      t.integer :user_id
      t.integer :company_id
      t.timestamps
    end
  end
end
