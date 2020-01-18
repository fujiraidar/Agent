class Companies::CompaniesController < ApplicationController

	def show
		@company = Company.find(params[:id])
		@jobs = @company.jobs
		@marks = @company.marks
		@offers = @company.offers
	end

	def index
		@companies = Company.all
		@offer = Offer.new
	end

	def edit
		@company = Company.find(params[:id])
	end

	def update
		@company = Company.find(params[:id])
		if @company.update(company_params)
			redirect_to company_path(current_compny.id)
		else
			render :edit
		end
	end

	private

	def company_params
		params.require(:company).permit(:surname, :name, :company_image, :introduction)
	end
end
