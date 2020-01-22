class Companies::JobsController < ApplicationController

    before_action :signed_in?
	before_action :correct_company, only: [:edit, :update, :destroy]

	def new
		@job = Job.new
	end

	def show
		@job = Job.find(params[:id])
	end

	def index
		if params[:q] != nil
            params[:q]['title_or_status_or_salary_or_job_cont_any'] = params[:q]['title_or_status_or_salary_or_job_cont_any'].split(/[\p{blank}\s]+/)
            @q = Job.ransack(params[:q])
            @jobs = @q.result(distinct: true).page(params[:page]).per(10)
        else
            @q = Job.ransack(params[:q])
            @jobs = Job.page(params[:page]).per(10)
        end
	end

	def edit
	end

	def create
		@job = Job.new(job_params)
		@job.company_id = current_company.id
		if @job.save
			redirect_to job_path(@job)
			flash[:notice] = "求人登録が完了しました！"
		else
			render :new
		end
	end

	def update
		if @job.update(job_params)
			flash[:notice] = "求人情報を更新しました！"
			redirect_to job_path(@job)
		else
			render :edit
		end
	end

	def destroy
		@job.destroy
		redirect_to engineers_path
	end

	private

	def job_params
		params.require(:job).permit(:company_id, :job_image, :title, :job, :salary, :status)
	end

	def signed_in?
        unless user_signed_in? or company_signed_in?
            redirect_to root_path
        end
    end

	def correct_company
        @job = Job.find(params[:id])
        if user_signed_in? or current_company != @job.company
            redirect_to users_path
        end
    end

end
