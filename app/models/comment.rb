class Comment < ApplicationRecord
	belongs_to :help
	belongs_to :user

	validates :comment, presence: true
end
