class Companies::EngineersController < ApplicationController

	def index
		@engineers = Engineer.where(offer: 1)
		@offer = Offer.new
	end
end