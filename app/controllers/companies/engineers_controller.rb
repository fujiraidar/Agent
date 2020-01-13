class Companies::EngineersController < ApplicationController

	def index
		@engineer = Engineer.all
	end
end
