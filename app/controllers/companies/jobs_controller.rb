class Companies::JobsController < ApplicationController

	def new
		@job = Job.new
	end

	def show
		@job = Job.find(params[:id])
	end

	def edit
		@job = Job.find(params[:id])
	end

	def create
		job = Job.new(job_params)
		if job.save
			redirect_to job_path(job)
		else
			render :new
		end
	end

	def update
		job = Job.find(params[:id])
		if job.update(job_params)
			redirect_to job_path(job)
		else
			render :edit
		end
	end

	def destroy
		job = Job.find(params[:id])
		job.destroy
		redirect_to engineers_path
	end

	private

	def job_params
		params.require(:job).permit(:company_id, :job, :salary, :status)
	end

end
