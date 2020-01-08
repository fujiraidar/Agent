class Users::HelpsController < ApplicationController

	def new
		@help = Help.new
	end

	def show
		@help = Help.find(params[:id])
	end

	def edit
		@help = Help.find(params[:id])
	end

	def index
		@helps = Help.all
	end

	def create
		help = Help.new(help_params)
		help.user_id = current_user.id
		if help.save
			redirect_to user_help_path(current_user.id,help)
		else
			render :new
		end
	end

	def update
		help = Help.find(params[:id])
		if help.update(help_params)
			redirect_to user_help_path(help)
		else
			render :edit
		end
	end

	def destroy
		help = Help.find(params[:id])
		help.destroy
		redirect_to user_helps_path
	end

	private

	def help_params
		params.require(:help).permit(:user_id, :language, :title, :help)
	end
end
