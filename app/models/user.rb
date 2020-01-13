class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :engineer

  has_many :helps

  has_many :favorites, dependent: :destroy
  has_many :favorite_infos, through: :favorites, source: :info

  has_many :follows, dependent: :destroy
  has_many :follow_engineers, through: :follows, source: :engineer

end
