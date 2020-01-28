class Companies::CompaniesController < ApplicationController

	before_action :signed_in?
	before_action :deleted_company?, only: [:show]
	before_action :correct_company, only: [:edit ,:update]

	def show
		@company = Company.find(params[:id])
		@topics = @company.topics.page(params[:page]).per(10).order("created_at DESC")
		@jobs = @company.jobs.order("created_at DESC")
		@marks = @company.marks.order("created_at DESC")
		@offers = @company.offers.order("created_at DESC")
		@boxes = @company.boxes.order("created_at DESC")
	end

	def index
		@q = Company.ransack(params[:q])
        @companies = @q.result(distinct: true).page(params[:page]).per(10).order("created_at DESC")
		@offer = Offer.new
	end

	def edit
		@company = Company.find(params[:id])
	end

	def update
		@company = Company.find(params[:id])
		if @company.update(company_params)
			redirect_to company_path(current_company.id)
		else
			render :edit
		end
	end


	private

	def company_params
		params.require(:company).permit(:surname, :name, :company_image, :introduction)
	end

	def signed_in?
        unless user_signed_in? or company_signed_in?
            redirect_to root_path
        end
    end

    def deleted_company?
    	unless Company.with_deleted.find(params[:id]).deleted_at.nil?
            flash[:alert] = "no user!!!!!!!!"
            redirect_to users_path
        end
    end

	def correct_company
        @company = Company.find(params[:id])
        if user_signed_in? or current_company != @company
            redirect_to users_path
        end
    end
end
