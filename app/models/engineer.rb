class Engineer < ApplicationRecord

    acts_as_paranoid

    validates :surname, presence: true,
                   length: { maximum: 20 }

    validates :name, presence: true,
                   length: { maximum: 20 }

    validates :age, numericality: { only_integer: true }, allow_blank: true
    validates :age, presence: true, if: :offer_ok?
    def offer_ok?
      offer == "受け取る"
    end

    validates :offer, presence: true

	has_many :languages, inverse_of: :engineer
	accepts_nested_attributes_for :languages, reject_if: :all_blank, allow_destroy: true

    has_many :infos
    has_many :drafts, dependent: :destroy
    has_many :comments
    has_many :offers, dependent: :destroy
    has_many :boxes, dependent: :destroy

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
        駆け出しのAgent: 0,
        進化したAgent: 1,
        真のAgent: 2,
        無敵のAgent: 3,
        奇跡のAgent: 4,
        唯一無二のAgent: 5,
        SuperAgent: 6,
    	Agentman: 7,
    }

end
