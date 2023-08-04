class Post < ApplicationRecord
  #each post has many comments
  has_many :comments,dependent: :destroy
  #each post has many likes
  has_many :likes,dependent: :destroy
end
