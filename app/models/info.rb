class Info < ApplicationRecord
	belongs_to :engineer
	has_many :favorites, dependent: :destroy
    has_many :favoriting_users, through: :favorites, source: :user

    validates :title, presence: true
	validates :language, presence: true
	validates :body, presence: true
end
