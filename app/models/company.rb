class Company < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :company_image

  has_many :jobs
  has_many :offers

  has_many :marks, dependent: :destroy
  has_many :marking_users, through: :marks, source: :engineer

end
