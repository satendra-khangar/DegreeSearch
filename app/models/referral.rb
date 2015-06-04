class Referral

  include HTTParty
  base_uri 'http://staging.degreesearch.org'
  COUNTRY = "US"
  LANDING_URL = "call_verified/index"
  PROVIDER_ID = 9631
  LEAD_PROCESS_NAME = "call_varified"
  

  def initialize(params)
   params1 = params.each{|k,v| params.delete(k) if v.blank? }
   @body = params1.merge({:country => COUNTRY, :provider_id => PROVIDER_ID, :landing_url => LANDING_URL, :lead_process_name => LEAD_PROCESS_NAME})

  end

  def create_referral
   	
    @result = self.class.post("/api/lip/referrals",
    { 
     :body => @body.to_json,
     :basic_auth =>  { :username => "integration", :password => "g1v1ngL1pS3rv1c3" },
     :headers => {'Content-Type' => 'application/json', 'Accept' => 'application/json'}
    })
  end

  def search_school

  	 self.class.post("/api/lip/searches", 
  	 {
	 	:body => {"referral_id" => create_referral["id"].to_s }.to_json,
	 	:basic_auth =>  { :username => "integration", :password => "g1v1ngL1pS3rv1c3" },
 		:headers => {'Content-Type' => 'application/json', 'Accept' => 'application/json'}
  	 })

  end

end