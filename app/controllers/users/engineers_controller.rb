class Users::EngineersController < ApplicationController

	def new
		@engineer = Engineer.new
	end

	def show
		@engineer = Engineer.find(params[:id])
	end

    def edit
    	@engineer = Engineer.find(params[:id])
    end

    def create
    	engineer = Engineer.new(engineer_params)
        engineer.user_id = current_user.id
        engineer.id = current_user.id
    	if engineer.save
    		redirect_to user_path(current_user.id)
    	else
    		render :new
    	end
    end

    def update
    	engineer = Engineer.find(params[:id])
    	if engineer.update(engineer_params)
    		redirect_to user_path(current_user.id)
    	else
    		render :edit
    	end
    end

    def destroy
    	engineer = Engineer.find(params[:id])
    	engineer.destroy
    	redirect_to infos_path
    end

    private

    def engineer_params
    	params.require(:engineer).permit(:user_id, :surname, :name, :age, :profile_image, :introduction, :rank, :offer, languages_attributes: [:id, :language ,:experience_year, :description, :done, :_destroy,
                                                         performances_attributes: [:id, :performance, :description, :_destroy]])
    end
end
