class Admins::AdminsController < ApplicationController

	before_action :admin?

	def index
		@contacts = Contact.all.page(params[:page]).per(10).order("created_at DESC")
	end

	private

	def admin?
		unless admin_signed_in?
			redirect_to root_path
		end
	end
end
