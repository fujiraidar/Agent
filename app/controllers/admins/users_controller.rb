class Admins::UsersController < ApplicationController

	before_action :admin?

	def index
		@users = User.with_deleted.page(params[:page]).per(20)
	end

	def update
		@user =  User.with_deleted.find(params[:id])
		if @user.restore
			flash[:notice] = "復活!!!!!!!!!!!!!!!!!!!!!!!!!!"
            redirect_to  admins_admins_path
        else
        	render :index
        end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		flash[:notice] = "復活!!!!!!!!!!!!!!!!!!!!!!!!!!"
		redirect_to  admins_admins_path
	end

	private

	def admin?
		unless admin_signed_in?
			redirect_to root_path
		end
	end
end
