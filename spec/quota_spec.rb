require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe ".quota" do

  let(:as) {SentimentAnalysis::Client.new(:api_key => API_KEY)}


  context "without parameter" do
    use_vcr_cassette "quota_without_parameter", :record => :new_episodes
    let(:quota) {as.quota}

    it 'returns the number of remaining API calls in a Hash-like object' do
      quota.should ==  1234
    end
  end


  context "with (:format => :json)" do
    use_vcr_cassette "quota_with_json_format_parameter", :record => :new_episodes
    let(:quota) {as.quota(:format => :json)}

    it('fetches JSON data') { quota.response.content_type.should == 'application/json' }

    it 'returns the number of remaining API calls in a Hash-like object' do
      quota.should ==  {"quota_remaining"=>4976}
      quota["quota_remaining"].should ==   4976
    end
  end


  context "with (:format => :xml)" do
    use_vcr_cassette "quota_with_xml_format_parameter", :record => :new_episodes

    it 'returns the number of remaining API calls in an XML string' do
      as.quota(:format => :xml).should == xml_fixture('quota_success.xml')
    end
  end


# Error handling
#----------------

  example "with (:format => :invalid-format raises a FormatError)" do
    expect{
      as.quota(:format => :invalid_format)
    }.to raise_error(SentimentAnalysis::FormatError)
  end

end
