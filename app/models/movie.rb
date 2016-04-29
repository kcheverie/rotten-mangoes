class Movie < ActiveRecord::Base
  scope :text, -> (text) { where("title LIKE ? OR director LIKE ? OR description LIKE ?", "%#{text}%","%#{text}%","%#{text}%") }
  scope :runtime_in_minutes, -> (runtime_in_minutes) { 
    case runtime_in_minutes
      when "< 90"
       where("runtime_in_minutes < ?", 90)
      when "90-120"
        where("runtime_in_minutes >= ? AND runtime_in_minutes <= ?", 90, 120)
      when "120+"
        where("runtime_in_minutes > ?", 120)
      end
  }

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
