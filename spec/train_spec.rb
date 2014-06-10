require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe '.train' do

  let(:as) {SentimentAnalysis::Client.new(:api_key => API_KEY)}


  context "without a format parameter" do
    use_vcr_cassette "train with a negative mood", :record => :new_episodes

    before() do
      @result = as.train(:text => "I don't like coffee'",:mood => 'negative')
    end

    it('fetches JSON data') { @result.response.content_type.should == 'application/json' }

    it 'returns the OK status in a Hash-like object' do
      @result.should == {"status"=>200, "error"=>nil}
      @result['status'].should == 200 
    end
  end


  context "with (:format => :json)" do
    use_vcr_cassette "train with a negative mood", :record => :new_episodes

    before() do
      @result = as.train(:text => "I don't like coffee'",:mood => 'negative', :format => :json)
    end

    it('fetches JSON data') { @result.response.content_type.should == 'application/json' }

    it 'returns the OK status in a Hash-like object' do
      @result.should ==  {"status"=>200, "error"=>nil}
      @result['status'].should ==  200
    end
  end


  context "with (:format => :xml)" do
    use_vcr_cassette "train with a negative mood", :record => :new_episodes

    before() do

    end

# Error handling
#----------------

    example ".train(:format => :invalid-format raises a FormatError)" do
      expect{
        as.train(:text => "I don't like coffee'",:mood => 'negative', :format => :invalid_format)
      }.to raise_error(SentimentAnalysis::FormatError)
    end

    example ".train without a :text parameter raises an ArgumentError" do
      expect{
        as.train(:mood => 'negative')
      }.to raise_error(ArgumentError)
    end

    example ".train without a :text parameter raises an ArgumentError" do
      expect{
        as.train(:text => "I don't like coffee'")
      }.to raise_error(ArgumentError)
    end

  end
end
