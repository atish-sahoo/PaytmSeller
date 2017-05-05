module PaytmSeller
	module Order

		def fetch_orders
			begin
				url = @environment.eql?(:production) ? "https://fulfillment.paytm.com/v1/merchant/#{@merchant_id}/orders.json" : "https://fulfillment-staging.paytm.com/v1/merchant/#{@merchant_id}/orders.json"

				params = {'authtoken' => @access_token}
				headers = {'Connection'=> 'keep-alive','Cache-Control' => 'max-age=0'}

				response = RestClient::Request.execute(method: :get, url: url, timeout: 10, headers: {params: params}.merge!(headers))
				response_data = JSON.parse(response.body)

				return response_data
			rescue RestClient::ExceptionWithResponse => e
				puts e.message
				return false
			end
			
		end

	end
end