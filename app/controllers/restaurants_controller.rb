class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :dashboard, :favorite, :unfavorite, :like, :unlike,:ranks]
  def index
    @restaurants = Restaurant.page(params[:page]).per(9)
    @categories = Category.all
  end

  def show
    
    @comment = Comment.new
    
  end

  def feeds
    @recent_restaurants = Restaurant.order(created_at: :desc).limit(10)
    @recent_comments = Comment.order(created_at: :desc).limit(10)
  end

  def dashboard
    
  end

  def favorite
    @restaurant.favorites.create!(user: current_user)
    
    redirect_back(fallback_location: root_path)
  end

  def unfavorite
    favorite = Favorite.where(restaurant: @restaurant, user: current_user).first

    favorite.destroy
    redirect_back(fallback_location: root_path)
  end

  def like
    @restaurant.likes.create!(user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def unlike
    like = Like.where(restaurant: @restaurant, user: current_user).first
    like.destroy
    redirect_back(fallback_location: root_path)
  end

  def ranks
    Restaurant.all.each do |restaurant|
      restaurant.favorites_count = restaurant.favorited_users.count
      restaurant.save
    end

    @favorites_restaurants = Restaurant.order(favorites_count: :desc).limit(10)
  end

  private
  def set_restaurant
    @restaurant = Restaurant.find(params[:id])  
  end
end
