class Users::InterviewsController < ApplicationController

	def create
        @interview = Interview.new(interview_params)
        @box = @interview.box
        @interviews = Interview.where(box_id: @box.id)
        if @interview.save
            @interview = Interview.new
            # render :create
        end
    end

    private

    def interview_params
    	params.require(:interview).permit(:box_id, :message)
    end
end
