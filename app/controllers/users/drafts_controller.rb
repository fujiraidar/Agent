class Users::DraftsController < ApplicationController

    before_action :authenticate_user!, only: [:index, :edit, :update, :destroy]
	before_action :correct_user, only: [:edit, :update, :destroy]

	def index
		@engineer = Engineer.find_by(id: current_user.id)
		@drafts = @engineer.drafts.page(params[:page]).per(10).order("created_at DESC")
	end

	def edit
	end

	def update
		if params[:commit] == "投稿する"
			@info = Info.new(draft_params)
			@info.engineer_id = current_user.id
			if @info.save
				@draft.destroy
				flash[:notice] = "記事の投稿が完了しました！"
				redirect_to info_path(@info)
			else
				render :edit
			end
		else
			if @draft.update(draft_params)
				flash[:notice] = "下書き保存しました！"
				redirect_to engineer_path(current_user.id)
			else
				render :edit
			end
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

	def correct_user
        @draft = Draft.find(params[:id])
        if current_user.id != @draft.engineer_id
            redirect_to infos_path
        end
    end

end
