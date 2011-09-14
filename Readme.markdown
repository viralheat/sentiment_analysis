# The Sentiment Analysis Ruby Gem
A Ruby wrapper for the Viralheat Sentiment Analysis API

see : [http://viralheat.com/developer/sentiment_api](http://viralheat.com/developer/sentiment_api)

## <a name="installation">Installation</a>

gem install sentiment_analysis

## <a name="installation">Getting an API Key</a>

You can get an API key by visiting http://www.viralheat.com/developer. Sign up as a FREE developer and get a key for use with this gem. The developer dashboard will also show you details on your quota.

## <a name="how to use">How to use</a>


Simple way

	require 'sentiment_analysis'
	sa = SentimentAnalysis::Client.new(:api_key => '0123456789')
	
	puts sa.quota
	  # => 5000

	puts as.review("i don't like this")
	  # => {"prob":0.732603741199471,"mood":"negative","text":"i don't like this"}

	puts as.train(:text => "I don't like coffee'",:mood => 'negative')
      # => {"status":"ok"}
	

Choose the format - :json

	puts sa.quota(:format => :json)
	  # => {"quota_remaining":5000}


Choose the format - :xml

	puts sa.quota(:format => :xml)
	  # => <?xml version="1.0" encoding="UTF-8"?>
		   <result>
	  	     <quota_remaining>4976</quota_remaining>
		   </result>

	puts as.review("i don't like this", :format => :xml)
	  # => <?xml version="1.0" encoding="UTF-8"?>
  		   <result>
  		     <text>I don't like coffee</text>
  		     <mood>negative</mood>
  		     <prob>0.55865964876338</prob>
  		   </result>
 
	puts as.train(:text => "I don't like coffee'",:mood => 'negative', :format => :xml)
	  # => <?xml version="1.0" encoding="UTF-8"?>
		   <result>
		     <status>ok</status>
		   </result>
	
