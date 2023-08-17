# frozen_string_literal: true

class Post < ApplicationRecord
  # each post has many comments
  has_many :comments, dependent: :destroy
  # each post has many likes
  has_many :likes, dependent: :destroy

  # active storage association for posts
  has_one_attached :image
  
  # has_many_attached :image
end
