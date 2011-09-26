require 'httparty'

module SentimentAnalysis
  class Client
    include ::HTTParty

    base_uri 'viralheat.com/api/sentiment'

    def initialize(options)
      @api_key = options[:api_key]
    end


    def quota(options={})
      query    = {:api_key => @api_key}
      response = get_response_for(:quota, :options => options, :query => query)

      case options[:format]
        when nil      then response['quota_remaining']
        when :json    then response
        when :xml     then response.body
      end
    end


    def train(options)
      raise ArgumentError.new(":text parameter is missing") unless options[:text]
      raise ArgumentError.new(":mood parameter is missing") unless options[:mood]

      query    = {:api_key => @api_key, :text => options[:text], :mood => options[:mood] }
      response = get_response_for(:train, :options => options, :query => query)

      options[:format] == :xml ?
        response.body :
        response
    end


    def review(options)
      raise ArgumentError.new(":text parameter is missing") unless options[:text]

      query    = {:api_key => @api_key, :text => options[:text]}
      response = get_response_for(:review, :options => options, :query => query)

      options[:format] == :xml ?
        response.body :
        response
    end

  private

    def get_response_for(action, params)
      url   = url_for(action, params[:options])
      query = params[:query]
      self.class.get(url, :query => query)
    end

    def url_for(base, options)
      format = options[:format] || :json
      if [:json, :xml].include?(format)
        "/#{base}.#{format}"
      else
        raise SentimentAnalysis::FormatError.new("Invalid format : #{format}")
      end
    end

  end
end
