class Restaurant < ApplicationRecord
  mount_uploader  :image, PhotoUploader
  validates_presence_of :name
  belongs_to :category, optional: true
  has_many :comments ,dependent: :destroy
  has_many :favorites , dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :liked_users, through: :likes, source: :user
  def is_favorited?(user)
    self.favorited_users.include?(user)
  end
  def is_liked?(user)
    self.liked_users.include?(user)
  end


  def set_favorites_count
    Restaurant.all.each do |restaurant|
      restaurant.favorites_count = restaurant.favorited_users.count
      restaurant.save
    end

    
  end
end
