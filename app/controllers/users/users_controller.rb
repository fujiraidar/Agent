class Users::UsersController < ApplicationController

    before_action :authenticate_user!, only: [:show, :edit, :create, :update, :destroy]
    before_action :signed_in?, only: [:show]
    before_action :correct_user, only: [:edit, :update, :destroy ,:withdraw]

	def show
        @user = User.find(params[:id])
        if params[:q] != nil
            params[:q]['title_or_body_or_language_cont_any'] = params[:q]['title_or_body_or_language_cont_any'].split(/[\p{blank}\s]+/)
            @q_help = Help.ransack(params[:q])
            help = @q_help.result(distinct: true).page(params[:page]).per(10)
            @helps = @user.help
        else
            @q_help = Help.ransack(params[:q])
            @helps = @user.helps.page(params[:page]).per(10)
        end
        @favorites = @user.favorites
        @favorites = Favorite.page(params[:page]).per(10)
        @follows = @user.follows
        @follows = Follow.page(params[:page]).per(10)
	end

    def index
        if params[:q] != nil
            params[:q]['title_or_body_or_language_cont_any'] = params[:q]['title_or_body_or_language_cont_any'].split(/[\p{blank}\s]+/)
            @q_info = Info.ransack(params[:q])
            @infos = @q_info.result(distinct: true).page(params[:page]).per(10)
            @q_help = Help.ransack(params[:q])
            @helps = @q_help.result(distinct: true).page(params[:page]).per(10)
        else
            @q_info = Info.ransack(params[:q])
            @q_help = Help.ransack(params[:q])
            @infos = Info.page(params[:page]).per(10)
            @helps = Help.page(params[:page]).per(10)
        end
        @good_infos = Info.all.order('favorites_count desc').page(params[:page]).per(10)
        render :index
    end

	def edit
	end

	def update
        if @user.update(user_params)
           flash[:notice] = "変更しました!"
           redirect_to user_path(current_user.id)
        else
            render :edit
        end
    end

    def withdraw
    end

	def destroy
        @user.destroy
        redirect_to root_path
	end


	private

    def user_params
        params.require(:user).permit(:name)
    end

    def signed_in?
        if company_signed_in?
            redirect_to company_path(current_company.id)
        end
        unless User.with_deleted.find(params[:id]).deleted_at.nil?
            flash[:alert] = "no user!!!!!!!!"
            redirect_to users_path
        end
    end


    def correct_user
        @user = User.find(params[:id])
        if current_user != @user
            redirect_to users_path
        end
    end

end
