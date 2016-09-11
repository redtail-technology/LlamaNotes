module UsersHelper
  def get_webhook(company_id, hook_token)
    if hook_token.present?
      link = link_to "#{api_v1_webhooks_path(hook_token)[0...35]}...",
                     webhooks_path(hook_token), remote: true
    else
      link = link_to 'Generate webhook', webhooks_path(company_id),
                     method: :POST, remote: true
    end

    link
  end
end
