class Companies::TopicsController < ApplicationController

    before_action :signed_in?
	before_action :correct_company, only: [:edit, :update, :destroy]

	def new
		@topic = Topic.new
	end

	def show
		@topic = Topic.find(params[:id])
	end

	def edit
	end

	def create
		topic = Topic.new(topic_params)
		topic.company_id = current_company.id
		if topic.save
			flash[:notice] = "トピックの投稿が完了しました！"
			redirect_to topic_path(topic)
		else
			render :new
		end
	end

	def update
		if topic.update(topic_params)
			flash[:notice] = "トピックの更新が完了しました！"
			redirect_to topic_path(topic)
		else
			render :edit
		end
	end

	def destroy
		topic = Topic.find(params[:id])
		topic.destroy
		redirect_to engineers_path
	end

	private

	def topic_params
		params.require(:topic).permit(:company_id, :language, :title, :body)
	end

	def signed_in?
        unless user_signed_in? or company_signed_in?
            redirect_to root_path
        end
    end

	def correct_company
        topic = Topic.find(params[:id])
        if user_signed_in? or current_company.id != topic.company_id
            redirect_to users_path
        end
    end
end
