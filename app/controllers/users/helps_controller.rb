class Users::HelpsController < ApplicationController

    before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
	before_action :signed_in?, only: [:show]
	before_action :correct_user, only: [:edit, :update, :destroy]

	def new
		@help = Help.new
	end

	def show
		@help = Help.find(params[:id])
		@comment = Comment.new
		@comments = Comment.where(help_id: @help.id)
	end

	def edit
	end

	def create
		@help = Help.new(help_params)
		@help.user_id = current_user.id
		if help.save
			flash[:notice] = "ヘルプの投稿が完了しました！"
			redirect_to help_path(@help)
		else
			render :new
		end
	end

	def update
		if @help.update(help_params)
			flash[:notice] = "ヘルプ情報の更新が完了しました！"
			redirect_to help_path(@help)
		else
			render :edit
		end
	end

	def destroy
		@help.destroy
		redirect_to users_path
	end

	private

	def help_params
		params.require(:help).permit(:user_id, :language, :title, :body)
	end

	def signed_in?
        unless user_signed_in? or company_signed_in?
            redirect_to root_path
        end
    end

	def correct_user
        @help = Help.find(params[:id])
        if current_user != @help.user
            redirect_to users_path
        end
    end
end
