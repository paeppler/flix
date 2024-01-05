class Genre < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  has_many :characterizations, dependent: :destroy
  has_many :movies, through: :characterizations
end
