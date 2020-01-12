class Offer < ApplicationRecord

	belongs_to :company

	enum offer:{
		正社員: 1,
		契約社員: 2,
		アルバイト: 3,
		日雇い: 4,
		その他: 5,
    }
end
