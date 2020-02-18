class TopController < ApplicationController

	def top
	end

	def about
	end

	def contact
		@contact = Contact.new
	end

	def contacting
		@contact = Contact.new(contact_params)
		if @contact.save
			flash[:notice] = "お問い合わせを送信いたしました！"
			redirect_to top_about_path
		else
			render :contact
		end
	end

	private

	def contact_params
        params.require(:contact).permit(:email, :content)
    end
end
