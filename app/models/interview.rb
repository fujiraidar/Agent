class Interview < ApplicationRecord

	belongs_to :box
	validates :message, presence: true
end
