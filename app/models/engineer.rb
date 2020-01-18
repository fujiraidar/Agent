class Engineer < ApplicationRecord

	has_many :languages, inverse_of: :engineer
	accepts_nested_attributes_for :languages, reject_if: :all_blank, allow_destroy: true

    has_many :infos
    has_many :comments
    has_many :offers

    belongs_to :user

    has_many :follows, dependent: :destroy
    has_many :following_users, through: :follows, source: :user

    has_many :marks, dependent: :destroy
    has_many :mark_companys, through: :marks, source: :company


	attachment :profile_image

	enum offer:{
		受け取らない: 0,
		受け取る: 1
    }

    enum rank:{
    	SS: 1,
    	S: 2,
    	A: 3,
    	B: 4,
    	C: 5,
    	D: 6,
    	E: 7,
    	F: 8,
    }

end
