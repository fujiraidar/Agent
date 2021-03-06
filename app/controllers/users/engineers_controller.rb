class Users::EngineersController < ApplicationController

    before_action :authenticate_user!, only: [:new,:edit,:create,:update,:evolution,:destroy]
    before_action :signed_in?, only: [:show]
    before_action :correct_user, only: [:edit, :update, :evolution, :destroy]
    before_action :already_agent, only: [:new, :create]

	def new
		@engineer = Engineer.new
	end

	def show
		@engineer = Engineer.find(params[:id])
        @languages = @engineer.languages
        @marks = @engineer.marks.page(params[:page]).per(10).order("created_at DESC")
        @offers = @engineer.offers.page(params[:page]).per(10).order("created_at DESC")
        @boxes = @engineer.boxes.page(params[:page]).per(10).order("created_at DESC")
        @offer = Offer.new

        if params[:q] != nil
            params[:q]['title_or_body_or_language_cont_any'] = params[:q]['title_or_body_or_language_cont_any'].split(/[\p{blank}\s]+/)
            @q_info = Info.ransack(params[:q])
            info = @q_info.result(distinct: true)
            @infos = @engineer.info.page(params[:page]).per(10).order("created_at DESC")
        else
            @q_info = Info.ransack(params[:q])
            @infos = @engineer.infos.page(params[:page]).per(10).order("created_at DESC")
        end

        if user_signed_in?
            @user = User.find(params[:id])
            @currentUserEntry = Entry.where(user_id: current_user.id)
            @userEntry=Entry.where(user_id: @user.id)
            unless @user.id == current_user.id
                @currentUserEntry.each do |cu|
                    @userEntry.each do |u|
                    if cu.room_id == u.room_id then
                        @isRoom = true
                        @roomId = cu.room_id
                    end
                    end
                end
            end
            unless @isRoom
                @room = Room.new
                @entry = Entry.new
            end
        end
	end

    def edit
    end

    def create
    	@engineer = Engineer.new(engineer_params)
        @engineer.user_id = current_user.id
        @engineer.id = current_user.id
    	if @engineer.save
            flash[:notice] = "Agent登録 完了!!！"
    		redirect_to engineer_path(current_user.id)
    	else
    		render :new
    	end
    end

    def update
    	if @engineer.update(engineer_params)
            flash[:notice] = "Agent情報の更新 完了!!！"
    		redirect_to engineer_path(current_user.id)
    	else
    		render :edit
    	end
    end

    def evolution
        x = 0
        @infos = @engineer.infos
        @infos.each do |i|
            x = x + i.favorites.count
        end
        x = x * 3
        y = @engineer.follows_count.to_i * 2
        x = x + y
        current_user.comments do |c|
            x = x + 1
        end
        if x > 500
            @engineer.update(rank: 8)
            redirect_to engineer_path(current_user.id)
        elsif x > 300
            @engineer.update(rank: 7)
            redirect_to engineer_path(current_user.id)
        elsif x > 200
            @engineer.update(rank: 6)
            redirect_to engineer_path(current_user.id)
        elsif x > 100
            @engineer.update(rank: 5)
            redirect_to engineer_path(current_user.id)
        elsif x > 50
            @engineer.update(rank: 4)
            redirect_to engineer_path(current_user.id)
        elsif x > 30
            @engineer.update(rank: 3)
            redirect_to engineer_path(current_user.id)
        elsif x > 10
            @engineer.update(rank: 2)
            redirect_to engineer_path(current_user.id)
        else
            @engineer.update(rank: 1)
            redirect_to engineer_path(current_user.id)
        end
    end

    private

    def engineer_params
    	params.require(:engineer).permit(:user_id, :surname, :name, :age, :profile_image, :introduction, :rank, :offer,
                                        languages_attributes: [:id, :language ,:experience_year, :description, :done, :_destroy,
                                        performances_attributes: [:id, :performance, :description, :_destroy]])
    end

    def signed_in?
        unless user_signed_in? or company_signed_in?
            redirect_to root_path
        end
        unless Engineer.with_deleted.find(params[:id]).deleted_at.nil?
            flash[:alert] = "no user!!!!!!!!"
            redirect_to infos_path
        end
    end

    def correct_user
        @engineer = Engineer.find(params[:id])
        if current_user != @engineer.user
            redirect_to infos_path
        end
    end

    def already_agent
        if Engineer.where(id: current_user.id).exists?
            flash[:notice] = "すでにAgent登録しています"
            redirect_to engineer_path(current_user.id)
        end
    end
end
