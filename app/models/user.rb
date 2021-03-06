class User < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :poeets
  has_many :favorites,dependent: :destroy
  # has_many :favorite_poeets, through: :favorites, source: :poeet
  before_validation { email.downcase! }
  validates :name, presence: true, length: {maximum: 30}
  validates :email, presence: true, length: {maximum: 255},
                    format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i},uniqueness:{case_sensitive:false}
  has_secure_password
  validates :password, presence: true, length: { minimum:6 }, on: :create
  validates :password_confirmation, presence: true, length: { minimum:6 }, on: :create
end
