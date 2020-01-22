class Companies::OffersController < ApplicationController

    before_action :signed_in?
    before_action :correct_company, only: [:destroy]

    def show
        @offer = Offer.find(params[:id])
        if user_signed_in?
            unless @offer.engineer_id == current_user.id
                redirect_to user_path(current_user.id)
            end
        end
    end

    def create
        @offer = Offer.new(offer_params)
        @offer.company_id = current_company.id
        if Offer.where(engineer_id: @offer.engineer_id, company_id: current_company.id).exists?
            flash[:notice] = "すでにオファーしています！"
            redirect_to engineer_path(@offer.engineer_id)
        else
            if @offer.save!
                flash[:notice] = "オファーを送信しました！"
                redirect_to offer_path(@offer)
            else
                @engineers = Engineer.where(offer: 1)
                @offer = Offer.new
                render template: "companies/engineers/index"
            end
        end
    end

    def destroy
        @offer = Offer.find(params[:id])
        @offer.destroy
        redirect_to company_path(current_company.id)
    end

    private

    def offer_params
    	params.require(:offer).permit(:company_id, :engineer_id, :title, :job, :status, :salary)
    end

    def signed_in?
        unless user_signed_in? or company_signed_in?
            redirect_to root_path
        end
    end

    def correct_company
        @offer = Offer.find(params[:id])
        if user_signed_in? or current_company != @offer.company
            redirect_to users_path
        end
    end
end
