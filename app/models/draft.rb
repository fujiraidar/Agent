class Draft < ApplicationRecord


	validates :title, presence: true
	validates :body, presence: true

	belongs_to :engineer

	acts_as_taggable
end
