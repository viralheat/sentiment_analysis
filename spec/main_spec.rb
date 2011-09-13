require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe SentimentAnalysis::Client do

  let(:as) {SentimentAnalysis::Client.new(:api_key => API_KEY)}

  describe ".quota" do
    it 'returns the remaining API calls quota in a Hash' do
      as.quota.class.should ==  Hash
      as.quota.should ==  {"quota_remaining"=>4999}
    end
  end

end
