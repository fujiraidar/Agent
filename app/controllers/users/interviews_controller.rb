class Users::InterviewsController < ApplicationController

    before_action :signed_in?

	def create
        @interview = Interview.new(interview_params)
        @box = @interview.box
        @interviews = Interview.where(box_id: @box.id)
        if @interview.save
            @interview = Interview.new
            redirect_to box_path(@box.id)
        end
    end

    def destroy
        @interview = Interview.find(params[:id])
        @interview.destroy
        redirect_to box_path(@interview.box_id)
    end

    private

    def interview_params
    	params.require(:interview).permit(:box_id, :message, :name)
    end

    def signed_in?
        unless user_signed_in? or company_signed_in?
            redirect_to root_path
        end
    end
end
