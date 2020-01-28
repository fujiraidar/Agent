class Admins::CompaniesController < ApplicationController

	before_action :admin?

	def index
		@companies = Company.with_deleted.page(params[:page]).per(20).order("created_at DESC")
	end

	def update
		@company = Company.with_deleted.find(params[:id])
		if @company.restore
			flash[:notice] = "復活!!!!!!!!!!!!!!!!!!!!!!!!!!"
            redirect_to  admins_admins_path
        else
        	render :index
        end
	end

	def destroy
		@company = Company.find(params[:id])
		flash[:notice] = "削除!!!!!!!!!!!!!!!!!!!!!!!!!!"
		@company.destroy
		redirect_to  admins_admins_path
	end

	private

	def admin?
		unless admin_signed_in?
			redirect_to root_path
		end
	end
end
