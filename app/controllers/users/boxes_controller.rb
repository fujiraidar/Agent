class Users::BoxesController < ApplicationController

    before_action :authenticate_user!, only: [:create]
    before_action :correct_user, only: [:show, :destroy]

	def show
		@box = Box.find(params[:id])
		@engineer = Engineer.find_by(id: @box.engineer_id)
		@company = Company.find_by(id: @box.company_id)
		@interview = Interview.new
		@interviews = @box.interviews
	end

	def create
		@box = Box.new(box_params)
		@box.save
		redirect_to box_path(@box)
	end

	def destroy
		@box = Box.find(params[:id])
		@box.destroy
		redirect_to engineer_path(current_user.id)
	end

	private

	def box_params
		params.require(:box).permit(:company_id, :engineer_id)
	end

	def correct_user
        @box = Box.find(params[:id])
        if user_signed_in?
	        if current_user.id != @box.engineer_id
	            redirect_to infos_path
	        end
	    elsif company_signed_in?
	    	if current_company.id != @box.company_id
	            redirect_to engineers_path
	        end
	    else
	    	redirect_to root_path
	    end
    end
end
