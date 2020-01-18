class Comment < ApplicationRecord
	belongs_to :help
	belongs_to :engineer
end
