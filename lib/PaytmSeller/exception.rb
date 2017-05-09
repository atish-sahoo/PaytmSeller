module PaytmSeller
  
  class StandardException < StandardError; end
  
  class Exception < StandardError 
	attr_reader :response

    def initialize(response)
      @response = response
    end

  end

  #for 412 response
  class InvalidDataException < Exception
  	def initialize(response)
      super(response)
    end
  end

  class OtherException < Exception
    def initialize(response)
      super(response)
    end
  end

end