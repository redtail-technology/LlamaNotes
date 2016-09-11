class DashboardController < ApplicationController
  def show
    puts Company.all
    @companies = generate_company_list if current_user.client?
  end

  # Generates list of companies and their respective hook tokens, if any.
  # Returns hash
  def generate_company_list
    arr = []
    webhooks = Webhook.where(user_id: current_user)
    companies = Company.all.order(:name)

    companies.each do |c|
      hook = webhooks.find { |hook| hook.company_id == c.id}
      token = hook[:token] if hook.present?

      arr.push(
        {
          id: c.id,
          name: c.name,
          icon_url: c.icon,
          webhook_token: token,
        }
      )
    end

    arr
  end
end
