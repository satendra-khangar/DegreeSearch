class HomeController < ApplicationController

  def referral
   
  end

  def search
    begin     
      @referral = Referral.new(params[:referral], true) 
      if @referral.valid?
        @res = @referral.search_school
      else 
        render 'referral'
      end
    rescue => e
      render :json => {:error => e.message }
    end
  end

  def custom_field
    begin
      @custom = Referral.new params
      @custom_fields = @custom.custom_fields_values(params["referral_id"], params["program_ids"], params['school_ids'])
    rescue => e
      render :json => {:error => e.message }
    end
  end

  def consent
    @custom = Referral.new params
    @consent = @custom.consent(params)
  end

  def lead
    begin
      @custom = Referral.new params
      @lead = @custom.lead(params)
    rescue => e
      render :json => {:error => e.message }
    end
  end
end
