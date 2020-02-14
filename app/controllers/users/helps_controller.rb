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

	def index
		if params[:tag]
	        @helps = Help.tagged_with(params[:tag]).page(params[:page]).per(10).order("created_at DESC")
	        @q_help = Help.ransack(params[:q])
		elsif params[:q] != nil
            params[:q]['title_or_body_or_tags_name_cont_any'] = params[:q]['title_or_body_or_tags_name_cont_any'].split(/[\p{blank}\s]+/)
            @q_help = Help.ransack(params[:q])
            @helps = @q_help.result(distinct: true).page(params[:page]).per(10).order("created_at DESC")
        else
            @q_help = Help.ransack(params[:q])
            @helps = Help.page(params[:page]).per(10).order("created_at DESC")
        end
        render :index
	end

	def edit
	end

	def create
		@help = Help.new(help_params)
		@help.user_id = current_user.id
		if @help.save
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
		redirect_to helps_path
	end

	private

	def help_params
		params.require(:help).permit(:user_id, :title, :body, :tag_list)
	end

	def signed_in?
        unless user_signed_in? or company_signed_in?
            redirect_to root_path
        end
    end

	def correct_user
        @help = Help.find(params[:id])
        if current_user != @help.user
            redirect_to helps_path
        end
    end
end
