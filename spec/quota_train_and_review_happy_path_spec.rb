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

    it('fetches JSON data') { quota.response.content_type.should == 'application/json' }

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

  example ".quota(:format => :invalid-format raises a FormatError)" do
    expect{
      as.quota(:format => :invalid_format)
    }.to raise_error(SentimentAnalysis::FormatError)
  end


#--------
# train
#--------

  describe ".train" do
    use_vcr_cassette "train with a negative mood", :record => :new_episodes

    before() do
      @result = as.train(:text => "I don't like coffee'",:mood => 'negative')
    end

    it('fetches JSON data') { @result.response.content_type.should == 'application/json' }

    it 'returns the OK status in a Hash-like object' do
      @result.should ==  {"status"=> 'ok'}
      @result['status'].should ==  'ok'
    end
  end


  describe ".train(:format => :json)" do
    use_vcr_cassette "train with a negative mood", :record => :new_episodes

    before() do
      @result = as.train(:text => "I don't like coffee'",:mood => 'negative', :format => :json)
    end

    it('fetches JSON data') { @result.response.content_type.should == 'application/json' }

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

    it 'returns the number of remaining API calls in an XML string' do
      @result.should == <<-XML
<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<result>
  <status>ok</status>
</result>
XML
    end

    example ".train(:format => :invalid-format raises a FormatError)" do
      expect{
        as.train(:text => "I don't like coffee'",:mood => 'negative', :format => :invalid_format)
      }.to raise_error(SentimentAnalysis::FormatError)
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

  describe ".review(:format => :json)" do
    use_vcr_cassette "review with :json format parameter", :record => :new_episodes

    before() do
      @result = as.review(:text => "I don't like coffee", :format => :json)
    end

    it 'returns the OK status in a Hash-like object' do
      @result.should ==  {"prob"=>0.55865964876338, "mood"=>"negative", "text"=>"I don't like coffee"}
      @result['prob'].should ==  0.55865964876338
    end
  end

  describe ".review(:format => :xml)" do
    use_vcr_cassette "review with :xml format parameter", :record => :new_episodes

    before() do
      @result = as.review(:text => "I don't like coffee", :format => :xml)
    end

    it 'returns the OK status in a XML String' do
      @result.should == <<-XML
<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<result>
  <text>I don't like coffee</text>
  <mood>negative</mood>
  <prob>0.55865964876338</prob>
</result>
XML
    end
  end

  example ".review(:format => :invalid-format raises a FormatError)" do
    expect{
      as.review(:text => "I don't like coffee", :format => :invalid_format)
    }.to raise_error(SentimentAnalysis::FormatError)
  end

end
