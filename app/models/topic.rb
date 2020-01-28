class Topic < ApplicationRecord
	belongs_to :company
	validates :title, presence: true
	validates :language, presence: true
	validates :body, presence: true
end
