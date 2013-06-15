require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook, '131672133640955', '3a3c2cbb5a7eda43d07573819a5f841f'
	provider :openid, :store => OpenID::Store::Filesystem.new('./tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'

  provider :twitter, 'QO4K9h7zQGN54AYyWMIbQ', 'uwySg97Z5vhWyxvEB4MXok663jGolymTAfGqave6M'
	provider :openid, :store => OpenID::Store::Filesystem.new('./tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'

	# TODO: some of these below are not needed
	# provider :openid, :store => OpenID::Store::Filesystem.new('./tmp'), :name => 'openid'
	#provider :google, 'domain.com', 'oauth_secret', :scope => 'https://mail.google.com/mail/feed/atom/'
end
