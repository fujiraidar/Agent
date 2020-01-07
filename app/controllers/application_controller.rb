class ApplicationController < ActionController::Base

	def before_sign_in_path_for(resource)
     root_path
    end

    def after_sign_in_path_for(resource)
     infos_path
    end
end
