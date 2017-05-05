module PaytmSeller
	require 'json'
	class Client < Base

		def initialize(merchant_id, username, password, client_id, client_secret, environment= :production)

			return false unless [:production,:sandbox].include?(environment)

			  @environment = environment

		      @base_url = @environment.eql?(:production) ? PRODUCTION_BASE_URL : SANDBOX_BASE_URL
		      @merchant_id = merchant_id
		      @username = username
		      @password = password
		      @client_id = client_id
		      @client_secret = client_secret
		      begin
		      	@access_token = get_access_token
		      	return true
		      rescue RestClient::ExceptionWithResponse => err
				  puts err.message
				  return false
			  end

		end


		private

			def get_access_token
				url = @environment.eql?(:production) ? PRODUCTION_BASE_URL+'/oauth2/token' : SANDBOX_BASE_URL+'/oauth2/token'

				code = get_auth_code

				payload = {
					'grant_type' => 'authorization_code',
					'code' => code,
					'client_id' => @client_id,
					'client_secret' => @client_secret
				}

				response = RestClient.post url, payload

				response_data =  JSON.parse(response.body)
				puts "access_token"
				puts response_data
				puts response_data['access_token']
				return response_data['access_token']

			end

			def get_auth_code
				url = @environment.eql?(:production) ? PRODUCTION_BASE_URL+'/oauth2/authorize' : SANDBOX_BASE_URL+'/oauth2/authorize'

				payload = {
					'username' => @username,
				   	'password' => @password,
				   	'client_id' => @client_id,
				   	'notredirect' => true,
				   	'response_type' => 'code'
				}

				response = RestClient.post url, payload

				response_data =  JSON.parse(response.body)
				return response_data['code']
			end
	end
end