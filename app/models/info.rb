class Info < ApplicationRecord
	belongs_to :engineer
	has_many :favorites, dependent: :destroy
    has_many :favoriting_users, through: :favorites, source: :user
end
