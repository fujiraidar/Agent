class Users::DraftsController < ApplicationController

    before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
	before_action :signed_in?, only: [:show]
	before_action :correct_user, only: [:edit, :update, :destroy]

	def new
		@draft = Draft.new
	end

	def index
		@engineer = Engineer.find_by(id: current_user.id)
		@drafts = @engineer.drafts
		@drafts = Draft.page(params[:page]).per(10)
	end

	def edit
		@info = Info.new
	end

	def create
		@draft = Draft.new
		@draft.title = ""
		@draft.language = ""
		@draft.body = ""
		@draft.engineer_id = current_user.id
		if @draft.save
			redirect_to edit_draft_path(@draft)
		end
	end

	def update
		@draft = Draft.find(params[:id])
		if @draft.update(draft_params)
		   @draft = Draft.find(params[:id])
		end
	end

	def destroy
		@draft.destroy
		redirect_to drafts_path
	end

	private

	def draft_params
		params.require(:draft).permit(:engineer_id, :language, :title, :body)
	end

	def signed_in?
        unless user_signed_in? or company_signed_in?
            redirect_to root_path
        end
    end


	def correct_user
        @draft = Draft.find(params[:id])
        if current_user.id != @draft.engineer_id
            redirect_to users_path
        end
    end

end
