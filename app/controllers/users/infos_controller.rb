class Users::InfosController < ApplicationController

	def new
		@info = Info.new
	end

	def show
		@info = Info.find(params[:id])
	end

	def edit
		@info = Info.find(params[:id])
	end

	def index
		@infos = Info.all
	end

	def create
		info = Info.new(info_params)
		info.user_id = current_user.id
		if info.save
			redirect_to user_engineer_info_path(current_user.id,@engineer,info)
		else
			render :new
		end
	end

	def update
		info = Info.find(params[:id])
		if info.update(info_params)
			redirect_to user_engineer_info_path(current_user.id,@engineer,info)
		else
			render :edit
		end
	end

	def destroy
		info = Info.find(params[:id])
		info.destroy
		redirect_to infos_path
	end

	private

	def info_params
		params.require(:info).permit(:user_id, :language, :title, :body)
	end
end
