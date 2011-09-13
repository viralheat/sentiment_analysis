require 'httparty'

module SentimentAnalysis
  class Client
    include ::HTTParty

    base_uri 'viralheat.com/api/sentiment'

    def initialize(options)
      @api_key = options[:api_key]
    end

    def quota
      self.class.get('/quota.json', :query => {:api_key => @api_key})
    end

    def train(options)
      self.class.get('/train.json', :query => {:api_key => @api_key, :text => options[:text], :mood => options[:mood] })
    end

    def review(options)
      self.class.get('/review.json', :query => {:api_key => @api_key, :text => options[:text]})
    end

  end
end
