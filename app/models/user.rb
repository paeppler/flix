class User < ApplicationRecord
  before_save :format_username

  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_movies, through: :likes, source: :movie

  has_secure_password
  
  validates :name, presence: true
  validates :email, format: { with: /\S+@\S+/ }, uniqueness: { case_sensitive: false }
  validates :username, format: { with: /\A[A-Z0-9]+\z/i }, uniqueness: { case_sensitive: false }

  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end

  def format_username
    self.username = username.downcase
  end

  def to_param
    username
  end
end
