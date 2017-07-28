class User < ApplicationRecord
  before_save { self.email = email.downcase }

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: true }, exclusion: { in: ["en"],
                                                                                                               message: "%{value} is reserved." }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 200 }, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, :on => :create

  has_many :categories

  has_and_belongs_to_many :images

  attr_accessor :file, :file_cache, :current_password
end
