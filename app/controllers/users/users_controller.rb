class Users::UsersController < ApplicationController

	def show
        @user = User.find(params[:id])
        @helps = current_user.helps
        if Engineer.where(id: current_user.id).exists?
		    @engineer = Engineer.find(current_user.id)
    		@languages = @engineer.languages
    		@infos = @engineer.infos
        end
	end

    def index
        @infos = Info.all
        @helps = Help.all
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
