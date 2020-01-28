class ApplicationController < ActionController::Base

    before_action :configure_permitted_parameters, if: :devise_controller?

	def before_sign_in_path_for(resource)
        root_path
    end

    def after_sign_in_path_for(resource)
        if user_signed_in?
            infos_path
        elsif company_signed_in?
            engineers_path
        elsif admin_signed_in?
            admins_admins_path
        end
    end

    def after_sign_out_path_for(resource)
        root_path
    end

    protected

	def configure_permitted_parameters
	    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :company_name, :company_address, :company_phone, :surname, ])
	end
end
