class Offer < ApplicationRecord

    belongs_to :engineer
	belongs_to :company


	validates :title, presence: true,
                   length: { minimum: 2 , maximum: 10 }
	validates :status, presence: true
	validates :salary, presence: true,
                   length: { minimum: 2 , maximum: 10 }
	validates :job, presence: true


	enum status:{
		正社員:1,
		契約社員:2,
		アルバイト:3,
		日雇い:4,
		その他:5,
    }
end
