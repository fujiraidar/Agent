class Draft < ApplicationRecord

	has_many :entries
	has_many :direct_messages
	has_many :users, through: :entries

	belongs_to :engineer
end
