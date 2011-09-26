require File.expand_path(File.dirname(__FILE__) + '/spec_helper')


context 'when the API key is invalid' do

  let(:as) {SentimentAnalysis::Client.new(:api_key => 'AN-invalid-API-key')}


#--------
# quota
#--------

  example 'calling quota() raises as InvalidApiKeyError ' do
    VCR.use_cassette "errors/quota with an invalid api key", :record => :new_episodes  do
      expect{ as.quota                    }.to raise_error(SentimentAnalysis::InvalidApiKeyError)
    end
  end


#--------
# train
#--------

  example 'calling train() raises as InvalidApiKeyError ' do
    VCR.use_cassette "errors/train with an invalid api key", :record => :new_episodes  do
      expect{
        as.train(:text => "I don't like coffee'",:mood => 'negative', :format => :json)
      }.to raise_error(SentimentAnalysis::InvalidApiKeyError)
    end
  end


#--------
# review
#--------

  example 'calling review() raises as InvalidApiKeyError ' do
    VCR.use_cassette "errors/review with an invalid api key", :record => :new_episodes  do
      expect{
        as.review(:text => "I don't like coffee", :format => :xml)
      }.to raise_error(SentimentAnalysis::InvalidApiKeyError)
    end
  end

end