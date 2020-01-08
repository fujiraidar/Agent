class Language < ApplicationRecord
	belongs_to :engineer
	has_many :performances, inverse_of: :language
	accepts_nested_attributes_for :performances, reject_if: :all_blank, allow_destroy: true
end
