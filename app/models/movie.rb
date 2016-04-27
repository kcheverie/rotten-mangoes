class Movie < ActiveRecord::Base

  mount_uploader :image, ImageUploader
  
  has_many :reviews

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  # validates :poster_image_url,
  #   presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past
  
  def self.search(title, director)
    if title && director
      Movie.where('title LIKE ? AND director LIKE ?', "%#{title}%", "%#{director}%")
    elsif title
      Movie.where('title LIKE ?', "%#{title}%")
    elsif director
      Movie.where('director LIKE ?', "%#{director}%")
    end
  end
  
  def review_average
      reviews.sum(:rating_out_of_ten)/reviews.size
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end
end
