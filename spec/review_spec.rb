require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe '.review' do

  let(:as) {SentimentAnalysis::Client.new(:api_key => API_KEY)}


  context "without a format parameter" do
    use_vcr_cassette "review", :record => :new_episodes

    before() do
      @result = as.review(:text => "I don't like coffee")
    end

    it 'returns the OK status in a Hash-like object' do
      @result.should ==  {"prob"=>0.55865964876338, "mood"=>"negative", "text"=>"I don't like coffee"}
      @result['prob'].should ==  0.55865964876338
    end
  end


  context "with (:format => :json)" do
    use_vcr_cassette "review with :json format parameter", :record => :new_episodes

    before() do
      @result = as.review(:text => "I don't like coffee", :format => :json)
    end

    it 'returns the OK status in a Hash-like object' do
      @result.should ==  {"prob"=>0.55865964876338, "mood"=>"negative", "text"=>"I don't like coffee"}
      @result['prob'].should ==  0.55865964876338
    end
  end


  context "with (:format => :xml)" do
    use_vcr_cassette "review with :xml format parameter", :record => :new_episodes

    it 'returns the OK status in a XML String' do
      result = as.review(:text => "I don't like coffee", :format => :xml)
      result.should == xml_fixture('review_success.xml')
    end
  end


# Error handling
#----------------

  example ".review(:format => :invalid-format raises a FormatError)" do
    expect{
      as.review(:text => "I don't like coffee", :format => :invalid_format)
    }.to raise_error(SentimentAnalysis::FormatError)
  end

  example ".review without a :text parameter raises an ArgumentError" do
    expect{
      as.review({})
    }.to raise_error(ArgumentError)
  end

end
