class Admins::CompaniesController < ApplicationController

	before_action :admin?

	def index
		@companies = Company.with_deleted
		@companies = Company.page(params[:page]).per(20)
	end

	def update
		@company =  Company.only_deleted.find(params[:id]).restore
        redirect_to  admins_admins_path
	end

	def destroy
		@company = Company.find(params[:id])
		@company.destroy
	end

	private

	def admin?
		unless admin_signed_in?
			redirect_to root_path
		end
	end
end
