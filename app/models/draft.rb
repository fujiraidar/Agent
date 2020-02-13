class Draft < ApplicationRecord


	validates :title, presence: true
	validates :language, presence: true
	validates :body, presence: true

	belongs_to :engineer
end
