class Post < ApplicationRecord
  #each post has many comments
  has_many :comments,dependent: :destroy
  #each post has many likes
  has_many :likes,dependent: :destroy

  #active storage association for posts
  has_one_attached :image
  has_one_attached :video
  has_many_attached :images
end
