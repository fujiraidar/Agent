class Users::FavoritesController < ApplicationController

	before_action :set_variables

    def favorite
        favorite = current_user.favorites.new(info_id: @info.id)
        favorite.save
    end

    def unfavorite
        favorite = current_user.favorites.find_by(info_id: @info.id)
        favorite.destroy
    end

    private

    def set_variables
        @info = Info.find(params[:info_id])
        @id_name = "#favorite-link-#{@info.id}"
    end

end
