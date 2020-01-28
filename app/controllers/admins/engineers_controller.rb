class Admins::EngineersController < ApplicationController

	before_action :admin?

	def index
		@engineers = Engineer.with_deleted.page(params[:page]).per(20).order("created_at DESC")
	end

	def update
		@engineer =  Engineer.only_deleted.find(params[:id])
		if @engineer.restore
			flash[:notice] = "復活!!!!!!!!!!!!!!!!!!!!!!!!!!"
	        redirect_to  admins_admins_path
	    else
	    	render :index
	    end
	end

	def destroy
		@engineer = Engineer.find(params[:id])
		@engineer.destroy
		redirect_to  admins_admins_path
	end

	private

	def admin?
		unless admin_signed_in?
			redirect_to root_path
		end
	end
end
