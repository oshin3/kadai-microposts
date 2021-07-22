class Micropost < ApplicationRecord
  belongs_to :user

  # お気に入り機能ここから
  has_many :favorites
  has_many :favorites, through: :favorites, source: :favorite
  has_many :reverses_of_favorite, class_name: 'Favorite', foreign_key: 'favorite_id'
  has_many :favorites, through: :reverses_of_favorite, source: :micropost
  
  def favorite(other_user)
    self.favorites.find_or_create_by(favorite_id: other_user.id)
  end

  def unfavorite(other_user)
    favorite = self.favorites.find_by(favorite_id: other_user.id)
    favorite.destroy if favorite
  end

  def favoriting?(other_user)
    self.favoritings.include?(other_user)
  end
  # お気に入り機能ここまで
  
  validates :content, presence: true, length: { maximum: 255 }
end