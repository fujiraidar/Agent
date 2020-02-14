class Job < ApplicationRecord

	belongs_to :company

	validates :title, presence: true
	validates :salary, presence: true
	validates :job, presence: true
	validates :status, presence: true

	attachment :job_image

	enum status:{
		正社員: 1,
		契約社員: 2,
		アルバイト: 3,
		日雇い: 4,
		その他: 5,
    }

    acts_as_taggable
end
