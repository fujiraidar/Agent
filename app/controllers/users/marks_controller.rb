class Users::MarksController < ApplicationController

	before_action :set_variables

    def mark
        mark = Engineer.find_by(id: current_user.id).marks.new(company_id: @company.id)
        mark.save
    end

    def unmark
        mark = Engineer.find_by(id: current_user.id).marks.find_by(company_id: @company.id)
        mark.destroy
    end

    private

    def set_variables
        @company = Company.find(params[:company_id])
        @id_name = "#mark-link-#{@company.id}"
    end

end
