module PaytmSeller
	module Product

		def update_products(data)
			begin
			  url = @environment.eql?(:production) ? "https://catalogadmin.paytm.com/v1/merchant/#{@merchant_id}/product.json" : "https://catalogadmin-staging.paytm.com/v1/merchant/#{@merchant_id}/product.json"
			  
			  response = RestClient::Request.execute(method: :post, url: url,timeout: 10, headers: {:content_type => 'application/json', params: {"authtoken" =>  @access_token}}, payload: data.to_json)

			  response_data = JSON.parse(response.body)

			  return response_data
			rescue RestClient::ExceptionWithResponse => e
				raise StandardException.new if e.response.blank?
				
				if e.response.code.present? && 412 == e.response.code
					raise InvalidDataException.new(e.response), e.message
				else
					raise OtherException.new(e.response), e.message
				end
			end
		end
	end
end