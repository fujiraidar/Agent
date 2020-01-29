class Draft < ApplicationRecord


	validates :title, presence: true
	validates :language, presence: true
	validates :body, presence: true

	has_many :entries
	has_many :direct_messages
	has_many :users, through: :entries

	belongs_to :engineer
end
