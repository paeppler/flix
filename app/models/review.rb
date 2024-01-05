class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates :comment, length: { minimum: 4 }

  validates :stars, numericality: {
  only_integer: true,
  minimum: 1,
  maximum: 5,
  message: "must be between 1 and 5"
  }

  # OR: 
  STARS = [1, 2, 3, 4, 5]

  # validates :stars, inclusion: {
  #   in: STARS,
  #   message: "must be between 1 and 5"
  # }

  def stars_as_percent
    (stars / 5.0) * 100.0
  end

  scope :past_n_days, ->(n) { where("created_at > ?", n.days.ago) }


  # where("released_on > ?", Time.now).order("released_on asc")
end
