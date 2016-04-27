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
  
  def self.search(search_params)
    @movies = Movie.all
    case search_params[:runtime_in_minutes]
      when "< 90"
        @movies = @movies.where("runtime_in_minutes < ?", 90)
      when "90-120"
        @movies = @movies.where("runtime_in_minutes >= ? AND runtime_in_minutes <= ?", 90, 120)
      when "120+"
        @movies = @movies.where("runtime_in_minutes > ?", 120)
      end
    title =  search_params[:title]
    director = search_params[:director]
    if !title.blank?
      @movies = @movies.where('title LIKE ?', "%#{title}%")
    end
    if !director.blank?
      @movies = @movies.where('director LIKE ?', "%#{director}%")
    end
    @movies
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
