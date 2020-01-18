class Companies::OffersController < ApplicationController

    def new
        @offer = Offer.new
    end

    def show
        @offer = Offer.find(params[:id])
    end

    def create
        offer = Offer.new(offer_params)
        offer.company_id = current_company.id
        if offer.save
            redirect_to offer_path(offer)
        else
            @engineers = Engineer.where(offer: 1)
            @offer = Offer.new
            render template: "companies/engineers/index"
        end
    end

    def destroy
        offer = Offer.find(params[:id])
        offer.destroy
        redirect_to company_path(current_company.id)
    end

    private

    def offer_params
    	params.require(:offer).permit(:company_id, :engineer_id, :title, :job, :status, :salary)
    end

end
