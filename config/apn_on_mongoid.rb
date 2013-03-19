  APN.setup do |config|

    config.host = 'gateway.push.apple.com'
    config.port = 2195

    config.feedback_host = 'feedback.push.apple.com'
    config.feedback_port = 2196

    config.cert = "#{::Rails.root.to_s}/config/my_custom_cert.pem"

    config.passphrase = 'ilikemangos'

  end