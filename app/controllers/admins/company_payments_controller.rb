class Admins::CompanyPaymentsController < ApplicationController

	before_action :admin?

	def index
		@company_payments = CompanyPayment.all.order("created_at DESC")
		@company_payments = CompanyPayment.page(params[:page]).per(10).order("created_at DESC")
	end

	def destroy
		@company_payment = CompanyPayment.find(params[:id])
		@company_payment.destroy
		flash[:notice] = "削除!!!!!!!!!!!!!!!!!!!!!!!!!!"
		redirect_to admins_company_payments_path
	end

	def admin?
		unless admin_signed_in?
			redirect_to root_path
		end
	end
end
