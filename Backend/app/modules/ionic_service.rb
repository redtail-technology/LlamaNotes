# Service class that is responsible for communicating with Ionic for push
# notifications
module IonicService
  def self.push(notification, device_id)
    uri = URI("https://api.ionic.io/push/notifications")
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Post.new(uri)
      req['Content-Type'] = 'application/json'
      req['Authorization'] = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiIyOWE0MTNiZS05NzcwLTQ0YmQtOWU3NS01ZmE3N2M1Mjc1ZGQifQ.zl8SQ3pfW6BI9Q7DCUffwZTwMvIczSlIjp6MB5FCP38'
      # The body needs to be a JSON string, use whatever you know to parse Hash to JSON
      req.body = {
        tokens: [device_id],
        profile: "robonotesdev",
        notification: {
          message: notification.message,
          payload: {
            icon_url: notification.icon_url,
            company_name: notification.company_name,
            message: notification.message,
            hour_created_at: notification.hour_created_at
          }
        }
      }.to_json
      http.request(req)
    end

    res
  end
end
