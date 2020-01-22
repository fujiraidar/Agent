class Companies::EngineersController < ApplicationController

    before_action :signed_in?

	def index
		if params[:q] != nil
            params[:q]['user_name_or_surname_or_name_or_age_or_introduction_or_languages_language_cont_any'] = params[:q]['user_name_or_surname_or_name_or_age_or_introduction_or_languages_language_cont_any'].split(/[\p{blank}\s]+/)
            @q = Engineer.ransack(params[:q])
            @engineers = @q.result(distinct: true).page(params[:page]).per(10)
        else
            @q = Engineer.ransack(params[:q])
            @engineers = Engineer.page(params[:page]).per(10)
        end
		@offer = Offer.new
	end

    private

    def signed_in?
        unless user_signed_in? or company_signed_in?
            redirect_to root_path
        end
    end
end