class Job < ApplicationRecord

	belongs_to :company

	enum job:{
		正社員: 1,
		契約社員: 2,
		アルバイト: 3,
		日雇い: 4,
		その他: 5,
    }
end
