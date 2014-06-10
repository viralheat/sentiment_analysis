require 'httparty'

module SentimentAnalysis
  class Client
    include ::HTTParty

    base_uri 'https://app.viralheat.com/social/api/sentiment'

    def initialize(options)
      @api_key = options[:api_key]
    end

    def train(options)
      raise ArgumentError.new(":text parameter is missing") unless options[:text]
      raise ArgumentError.new(":mood parameter is missing") unless options[:mood]
      query = {:api_key => @api_key, :text => options[:text], :mood => options[:mood] }

      case options[:format]
        when nil, :json then self.class.get('/train', :query => query)
        else
          raise SentimentAnalysis::FormatError.new("Invalid format : #{options[:format]}")
      end
    end


    def review(options)
      raise ArgumentError.new(":text parameter is missing") unless options[:text]
      query = {:api_key => @api_key, :text => options[:text]}

      case options[:format]
        when nil, :json then self.class.get('/', :query => query)
        else
          raise SentimentAnalysis::FormatError.new("Invalid format : #{options[:format]}")
      end
    end
  end
end
