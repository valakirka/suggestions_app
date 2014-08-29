class Suggestion < ActiveRecord::Base
  belongs_to :user
  has_many :ratings

  mount_uploader :image, ImageUploader

  def average_rating
    ratings.sum(:score) / ratings.size
  end
end
