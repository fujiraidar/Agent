class Users::InfosController < ApplicationController

    before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
	before_action :signed_in?, only: [:show]
	before_action :correct_user, only: [:edit, :update, :destroy]

	def new
		@info = Info.new
	end

	def show
		@info = Info.find(params[:id])
	end

	def edit
	end

	def create
		@info = Info.new(info_params)
		@info.engineer_id = current_user.id
		if @info.save
			flash[:notice] = "記事の投稿が完了しました！"
			redirect_to info_path(@info)
		else
			render :new
		end
	end

	def update
		if @info.update(info_params)
			flash[:notice] = "記事の更新が完了しました！"
			redirect_to info_path(@info)
		else
			render :edit
		end
	end

	def destroy
		@info.destroy
		redirect_to users_path
	end

	private

	def info_params
		params.require(:info).permit(:engineer_id, :language, :title, :body)
	end

	def signed_in?
        unless user_signed_in? or company_signed_in?
            redirect_to root_path
        end
    end


	def correct_user
        @info = Info.find(params[:id])
        if current_user.id != @info.engineer_id
            redirect_to users_path
        end
    end
end
