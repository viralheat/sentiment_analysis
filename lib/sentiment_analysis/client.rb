require 'httparty'

module SentimentAnalysis
  class Client
    include ::HTTParty

    base_uri 'viralheat.com/api/sentiment'

    def initialize(options)
      @api_key = options[:api_key]
    end

    def quota
      self.class.get('/quota.json', :query => {:api_key => @api_key}).to_hash
    end
  end
end
