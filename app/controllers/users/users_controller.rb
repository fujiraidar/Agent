class Users::UsersController < ApplicationController

	def show
        @user = User.find(params[:id])
        if params[:q] != nil
            params[:q]['title_or_body_or_language_cont_any'] = params[:q]['title_or_body_or_language_cont_any'].split(/[\p{blank}\s]+/)
            @q_help = Help.ransack(params[:q])
            help = @q_help.result(distinct: true)
            @helps = @user.help
        else
            @helps = @user.helps
        end
        @favorites = @user.favorites
        @follows = @user.follows
	end

    def index
        if params[:q] != nil
            params[:q]['title_or_body_or_language_cont_any'] = params[:q]['title_or_body_or_language_cont_any'].split(/[\p{blank}\s]+/)
            @q_info = Info.ransack(params[:q])
            @infos = @q_info.result(distinct: true)
            @q_help = Help.ransack(params[:q])
            @helps = @q_help.result(distinct: true)
        else
            @q_info = Info.ransack(params[:q])
            @infos = @q_info.result(distinct: true)
            @q_help = Help.ransack(params[:q])
            @helps = @q_help.result(distinct: true)
        end
    end

	def edit
		@user = User.find(params[:id])
	end

	def update
  	    @user = User.find(params[:id])
        if @user.update(user_params)
           flash[:notice] = "変更しました!"
           redirect_to user_path(current_user.id)
        else
            render :edit
        end
    end

    def unsubscribe
    	@user = User.find(params[:id])
    end

	def destroy
		@user = User.find(params[:id])
        @user.destroy
        redirect_to root_path
	end


	private

    def user_params
        params.require(:user).permit(:name)
    end

end
