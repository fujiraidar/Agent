class Users::UsersController < ApplicationController

    before_action :authenticate_user!, only: [:show, :index, :create, :update, :destroy ,:withdraw]
    before_action :signed_in?, only: [:show]
    before_action :correct_user, only: [:show, :update, :destroy ,:withdraw]

	def show
        @user = User.find(params[:id])
        if params[:q] != nil
            params[:q]['title_or_body_or_language_cont_any'] = params[:q]['title_or_body_or_language_cont_any'].split(/[\p{blank}\s]+/)
            @q_help = Help.ransack(params[:q])
            help = @q_help.result(distinct: true)
            @helps = @user.page(params[:page]).per(10).help.order("created_at DESC")
        else
            @q_help = Help.ransack(params[:q])
            @helps = @user.helps.page(params[:page]).per(10).order("created_at DESC")
        end
        @favorites = @user.favorites.page(params[:page]).per(10).order("created_at DESC")
        @follows = @user.follows.page(params[:page]).per(10).order("created_at DESC")
	end

    def index
        @rooms = current_user.rooms
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
            redirect_to infos_path
        end
    end


    def correct_user
        @user = User.find(params[:id])
        if current_user != @user
            redirect_to infos_path
        end
    end

end
