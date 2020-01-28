class Company < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  acts_as_paranoid

  validates :company_name, presence: true
  validates :company_address, presence: true
  validates :company_phone, presence: true
  validates :surname, presence: true
  validates :name, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :company_image

  has_many :topics, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :offers, dependent: :destroy
  has_many :company_payments, dependent: :destroy
  has_many :boxes, dependent: :destroy

  has_many :marks, dependent: :destroy
  has_many :marking_users, through: :marks, source: :engineer

end
