class Companies::CompanyPaymentsController < ApplicationController


	def new
		@company_payment = CompanyPayment.new
	end

    def create
		@company = current_company
	    @company_payment = @company.company_payments.build(company_payment_params)

	    @company.with_lock do
	      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
	      amount = 1200000
	      charge = Payjp::Charge.create(currency: 'jpy', amount: amount, card: params['payjp-token'])
	      @company_payment.charge_id = charge['id']
	      @company_payment.company_id = current_company.id

	      respond_to do |format|
	        if @company_payment.save
	          # ここに決済完了メール送る処理書くとよいと思います。
	          format.html { redirect_to company_path(@company), notice: '購入しました。' }
	        end
	      end
    end
  rescue Payjp::CardError
    respond_to do |format|
      format.html { redirect_to company_path(@company), notice: 'カードエラーが発生しました' }
    end
  end

  private
    def company_payment_params
      params.require(:company_payment).permit(:name)
    end
end
