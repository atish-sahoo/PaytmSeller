# PaytmSeller

Ruby Gem for Paytm Marketplace API.

This extension helps developers to integrate Paytm marketplace API easily in Rails application.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'PaytmSeller'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install PaytmSeller

## Usage

1. Create flipkart client object

	fk_client = PaytmSeller::Client.new(CLIENT_ID,CLIENT_SECRET)
	paytm_client = PaytmSeller::Client.new(MERCHANT_ID, USERNAME, PASSWORD, CLIENT_ID,CLIENT_SECRET)

2. Fetch your orders

	fk_client.fetch_orders

3. update product details

	data = {data: [{"sku" : "SKU001","qty" : 10},{"sku" : "SKU002","price" : 100, "mrp" : 80}]}

	begin
		paytm_client.update_products(data)
	rescue PaytmSeller::InvalidDataException => e
		puts e.response.body
	rescue PaytmSeller::OtherException => e

	end


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

