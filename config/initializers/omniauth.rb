Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, '535797241545-mkof36gogqqr0klluiouhrrms9f7oagf.apps.googleusercontent.com', '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'
  end