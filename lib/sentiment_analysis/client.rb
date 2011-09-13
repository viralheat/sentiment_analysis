require 'httparty'

module SentimentAnalysis
  class Client
    include ::HTTParty

    base_uri 'viralheat.com/api/sentiment'

    def initialize(options)
      @api_key = options[:api_key]
    end


    def quota(options={})
      query = {:api_key => @api_key}

      case options[:format]
        when nil      then self.class.get('/quota.json', :query => query)['quota_remaining']
        when :json    then self.class.get('/quota.json', :query => query)
        when :xml     then self.class.get('/quota.xml',  :query => query).body
        else
          raise SentimentAnalysis::FormatError.new("Invalid format : #{options[:format]}")
      end
    end


    def train(options)
      query = {:api_key => @api_key, :text => options[:text], :mood => options[:mood] }

      case options[:format]
        when nil, :json then self.class.get('/train.json', :query => query)
        when :xml       then self.class.get('/train.xml',  :query => query).body
        else
          raise SentimentAnalysis::FormatError.new("Invalid format : #{options[:format]}")
      end
    end


    def review(options)
      query = {:api_key => @api_key, :text => options[:text]}

      case options[:format]
        when nil, :json then self.class.get('/review.json', :query => query)
        when :xml       then self.class.get('/review.xml',  :query => query).body
        else
          raise SentimentAnalysis::FormatError.new("Invalid format : #{options[:format]}")
      end
    end

  end
end
