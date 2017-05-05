module PaytmSeller
	class Base
		include Order
		# include Product
		attr_reader :access_token
		attr_reader :environemnt
		attr_reader :base_url

	end
end