class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_picture_pass
  has_many :items, dependent: :destroy

  validates :name, presence: true
  validates :self_introduction, presence: true, length: { in: 50..200 }

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,100}+\z/i
  validates :password, format: { with: VALID_PASSWORD_REGEX }, on: :create
end
