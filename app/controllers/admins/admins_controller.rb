class Admins::AdminsController < ApplicationController

	before_action :admin?

	def index
	end

	private

	def admin?
		unless admin_signed_in?
			redirect_to root_path
		end
	end
end
