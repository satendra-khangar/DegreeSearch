class HomeController < ApplicationController

  def referral
  end

  def search
  	begin
	  	referral = Referral.new(params[:referral])
	  	@res = referral.search_school
	  	#render :json => @res.to_json
	rescue => e
	 	render :json => {:error => e.message }
	end
  end
end
