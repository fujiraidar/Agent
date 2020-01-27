class Admins::CompanyPaymentsController < ApplicationController

	before_action :admin?

	def index
		@company_payments = CompanyPayment.all
		@company_payments = CompanyPayment.page(params[:page]).per(10)
	end

	def destroy
		@company_payment = CompanyPayment.find(params[:id])
		@company_payment.destroy
		redirect_to admins_company_payments_path
	end

	def admin?
		unless admin_signed_in?
			redirect_to root_path
		end
	end
end
