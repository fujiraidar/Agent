class Help < ApplicationRecord
	belongs_to :user
	has_many :comments

	validates :title, presence: true
	validates :body, presence: true

	acts_as_taggable
end
