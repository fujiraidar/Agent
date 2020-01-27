class Box < ApplicationRecord

    belongs_to :engineer
    belongs_to :company
	has_many :interviews, dependent: :destroy
end
