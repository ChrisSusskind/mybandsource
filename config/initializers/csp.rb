# Disable secure headers
SecureHeaders::Configuration.default do |config|
  config.csp = SecureHeaders::OPT_OUT
end