class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  acts_as_paranoid

  validates :name, presence: true,
                   length: { minimum: 2 , maximum: 15 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :engineer, dependent: :destroy

  has_many :helps
  has_many :comments

  has_many :favorites, dependent: :destroy
  has_many :favorite_infos, through: :favorites, source: :info

  has_many :follows, dependent: :destroy
  has_many :follow_engineers, through: :follows, source: :engineer

  has_many :entries
  has_many :direct_messages, dependent: :destroy
  has_many :rooms, through: :entries

end
