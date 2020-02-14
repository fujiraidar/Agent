class Topic < ApplicationRecord

	belongs_to :company

	validates :title, presence: true
	validates :body, presence: true

	acts_as_taggable
end
