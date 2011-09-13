require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe SentimentAnalysis::Client do

  let(:as) {SentimentAnalysis::Client.new(:api_key => API_KEY)}

#--------
# quota
#--------

  describe ".quota" do
    use_vcr_cassette "quota_without_parameter", :record => :new_episodes
    let(:quota) {as.quota}

    it 'returns the number of remaining API calls in a Hash-like object' do
      quota.should ==  1234
    end
  end


  describe ".quota(:format => :json)" do
    use_vcr_cassette "quota_with_json_format_parameter", :record => :new_episodes
    let(:quota) {as.quota(:format => :json)}

    it('fetches JSON data') do
      quota.response.content_type.should == 'application/json'
    end

    it 'returns the number of remaining API calls in a Hash-like object' do
      quota.should ==  {"quota_remaining"=>4976}
      quota["quota_remaining"].should ==   4976
    end
  end

  describe ".quota(:format => :xml)" do
    use_vcr_cassette "quota_with_xml_format_parameter", :record => :new_episodes
    let(:quota) {as.quota(:format => :xml)}

    it 'returns the number of remaining API calls in an XML string' do
      quota.should == <<-XML
<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<result>
  <quota_remaining>4976</quota_remaining>
</result>
XML
    end
  end



#--------
# train
#--------

  describe ".train" do

    use_vcr_cassette "train with a negative mood", :record => :new_episodes

    before() do
      @result = as.train(:text => "I don't like coffee'",:mood => 'negative')
    end

    it('fetches JSON data') do
      @result.response.content_type.should == 'application/json'
    end

    it 'returns the OK status in a Hash-like object' do
      @result.should ==  {"status"=> 'ok'}
      @result['status'].should ==  'ok'
    end
  end

end
__END__
  describe ".train(:format => :json)" do

    use_vcr_cassette "train with a negative mood", :record => :new_episodes

    before() do
      @result = as.train(:text => "I don't like coffee'",:mood => 'negative', :format => :json)
    end

    it('fetches JSON data') do
      @result.response.content_type.should == 'application/json'
    end

    it 'returns the OK status in a Hash-like object' do
      @result.should ==  {"status"=> 'ok'}
      @result['status'].should ==  'ok'
    end
  end

  describe ".train(:format => :xml)" do

    use_vcr_cassette "train with a negative mood", :record => :new_episodes

    before() do
      @result = as.train(:text => "I don't like coffee'",:mood => 'negative', :format => :xml)
    end

    it('fetches JSON data') do
      @result.response.content_type.should == 'application/xml'
    end

    it 'returns the number of remaining API calls in an XML string' do
      @result.body.should == <<-XML
<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<result>
  <quota_remaining>4976</quota_remaining>
</result>
XML
    end
  end


#--------
# review
#--------

  describe ".review" do

    use_vcr_cassette "review", :record => :new_episodes

    before() do
      @result = as.review(:text => "I don't like coffee")
    end

    it 'returns the OK status in a Hash-like object' do
      @result.should ==  {"prob"=>0.55865964876338, "mood"=>"negative", "text"=>"I don't like coffee"}
      @result['prob'].should ==  0.55865964876338
    end
  end

end
