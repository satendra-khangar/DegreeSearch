class Referral

  include HTTParty
  base_uri 'http://staging.degreesearch.org'
  COUNTRY = "US"
  LANDING_URL = "call_verified/index"
  PROVIDER_ID = 9631
  LEAD_PROCESS_NAME = "call_varified"
	#CONSENT = 'consents_by_schools'
  CONSENT = 'edegree'

  attr_accessor :referral_id, :program_ids, :custom_fields

  def initialize(params)
    params1 = params.each{|k,v| params.delete(k) if v.blank? }
    @body = params1.merge({:country => COUNTRY, :provider_id => PROVIDER_ID, :landing_url => LANDING_URL, :lead_process_name => LEAD_PROCESS_NAME})
  end

  def create_referral
    self.class.post("/api/lip/referrals",
    { 
     :body => @body.to_json,
     :basic_auth =>  { :username => "integration", :password => "g1v1ngL1pS3rv1c3" },
     :headers => {'Content-Type' => 'application/json', 'Accept' => 'application/json'}
    })
  end

  def search_school
    @referral_id = create_referral["id"].to_s
    res = self.class.post("/api/lip/searches", 
    {
      :body => {"referral_id" => @referral_id }.to_json,
      :basic_auth =>  { :username => "integration", :password => "g1v1ngL1pS3rv1c3" },
      :headers => {'Content-Type' => 'application/json', 'Accept' => 'application/json'}
    })
    return res
  end

  def custom_fields_values(referral_id, program_ids)
    @referral_id = referral_id
    @program_ids = program_ids
    self.class.get("/api/lip/custom_fields?referral_id=#{@referral_id}&program_ids=#{program_ids}", {
      :body => referral_id.to_s,
      :basic_auth =>  { :username => "integration", :password => "g1v1ngL1pS3rv1c3" },
      :headers => {'Content-Type' => 'application/json', 'Accept' => 'application/json'}
    })  	
  end

  def consent(params)
    @referral_id = params[:referral_id]
    @custom_fields = params[:referral_id]
    self.class.get("/api/lip/consents?name=#{CONSENT}&school_ids=#{school_ids}", {
      :basic_auth =>  { :username => "integration", :password => "g1v1ngL1pS3rv1c3" },
      :headers => {'Content-Type' => 'application/json', 'Accept' => 'application/json'}
    })
  end

  def lead
    self.class.post("/api/lip/leads/submit", {
      :body => {"referral_id" => "96406687" ,:url => "collegefunnel/step4","program_ids" => "183297", :consent => "ono_portal_schools"}.to_json,
      :basic_auth =>  { :username => "integration", :password => "g1v1ngL1pS3rv1c3" },
      :headers => {'Content-Type' => 'application/json', 'Accept' => 'application/json'}
    })
  end
end