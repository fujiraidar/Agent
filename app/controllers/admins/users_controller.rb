class Admins::UsersController < ApplicationController

	def index
		@users = User.with_deleted
		@users = User.page(params[:page]).per(20)
	end

	def update
		@user =  User.only_deleted.find(params[:id]).restore
        redirect_to  admins_path
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
	end
end
