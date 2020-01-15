class Users::JobsController < ApplicationController

	def index
		@jobs = Job.all
	end
end
