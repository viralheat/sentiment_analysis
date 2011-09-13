require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe SentimentAnalysis::Client do

  let(:as) {SentimentAnalysis::Client.new(:api_key => API_KEY)}

#--------
# quota
#--------

  describe ".quota" do

    let(:quota) {as.quota}

    use_vcr_cassette "quota_without_parameter", :record => :new_episodes

    it('returns a Hash') { quota.should be_a Hash }

    it 'returns the number of remaining API calls' do
      quota.should ==  {"quota_remaining"=>1234}
    end
  end

end
