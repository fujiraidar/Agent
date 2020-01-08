class Users::EngineersController < ApplicationController

	def new
		@engineer = Engineer.new
		@language = Language.new
		@performance = Performance.new
	end

	def show
		@engineer = Enjineer.find(params[:id])
	end

    def edit
    	@engineer = Enjineer.find(params[:id])
    end

    def create
    	engineer = Engineer.new(engineer_params)
    	if engineer.save
    		redirect_to user_engineer_path(current_user.id,engineer)
    	else
    		render :new
    	end
    end

    def update
    	engineer = Enjineer.find(params[:id])
    	if engineer.update(engineer_params)
    		redirect_to user_engineer_path(current_user.id,engineer)
    	else
    		render :edit
    	end
    end

    def destroy
    	engineer = Enjineer.find(params[:id])
    	engineer.destroy
    	redirect_to infos_path
    end


    private

    def engineer_params
    	params.require(:engineer).permit(:profile_image_id, :introduction, :rank, :offer, languages_attributes: [:id, :language ,:experience_year, :description, :done, :_destroy,
                                                         performances_attributes: [:id, :performance, :description, :_destroy]])
    end
end
