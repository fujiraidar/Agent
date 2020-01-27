class Admins::EngineersController < ApplicationController

	before_action :admin?

	def index
		@engineers = Engineer.with_deleted
		@engineers = Engineer.page(params[:page]).per(20)
	end

	def update
		@engineer =  Engineer.only_deleted.find(params[:id]).restore
        redirect_to  admins_path
	end

	def destroy
		@engineer = Engineer.find(params[:id])
		@engineer.destroy
	end

	private

	def admin?
		unless admin_signed_in?
			redirect_to root_path
		end
	end
end
