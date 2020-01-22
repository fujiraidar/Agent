class Company < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  acts_as_paranoid

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :company_image

  has_many :topics, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :offers, dependent: :destroy

  has_many :marks, dependent: :destroy
  has_many :marking_users, through: :marks, source: :engineer

end
