class Users::InfosController < ApplicationController

    before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
	before_action :signed_in?, only: [:show]
	before_action :correct_user, only: [:edit, :update, :destroy]

	def new
		@info = Info.new
		@draft = Draft.new
	end

	def show
		@info = Info.find(params[:id])
	end

	def index
		if params[:q] != nil
            params[:q]['title_or_body_or_language_cont_any'] = params[:q]['title_or_body_or_language_cont_any'].split(/[\p{blank}\s]+/)
            @q_info = Info.ransack(params[:q])
            @infos = @q_info.result(distinct: true).page(params[:page]).per(10).order("created_at DESC")
        else
            @q_info = Info.ransack(params[:q])
            @infos = Info.page(params[:page]).per(10).order("created_at DESC")
        end
        render :index
	end

	def ranking
		@infos = Info.all.order('favorites_count desc').page(params[:page]).per(10).order("created_at DESC")
	end

	def edit
	end

	def create
		if params[:commit] == "投稿する"
			@info = Info.new(info_params)
			@info.engineer_id = current_user.id
			if @info.save
				flash[:notice] = "記事の投稿が完了しました！"
				redirect_to info_path(@info)
			else
				render :new
			end
		else
			@draft = Draft.new(info_params)
			@draft.engineer_id = current_user.id
			if @draft.save
				flash[:notice] = "下書き保存しました！"
				redirect_to engineer_path(current_user.id)
			else
				render :new
			end
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
		redirect_to infos_path
	end

	private

	def info_params
		params.require(:info).permit(:engineer_id, :language, :title, :body,)
	end

	def signed_in?
        unless user_signed_in? or company_signed_in?
            redirect_to root_path
        end
    end


	def correct_user
        @info = Info.find(params[:id])
        if current_user.id != @info.engineer_id
            redirect_to infos_path
        end
    end
end
