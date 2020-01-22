class Admins::EngineersController < ApplicationController

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
end
