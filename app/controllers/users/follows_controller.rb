class Users::FollowsController < ApplicationController

	before_action :set_variables

	def follow
		follow = current_user.follows.new(engineer_id: @engineer.id)
		follow.save
	end

	def unfollow
		follow = current_user.follows.find_by(engineer_id: @engineer.id)
		follow.destroy
	end

	private

	def set_variables
		@engineer = Engineer.find(params[:engineer_id])
		@id_name = "#follow-link-#{@engineer.id}"
    end
end
