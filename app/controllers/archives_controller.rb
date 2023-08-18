# frozen_string_literal: true

class ArchivesController < ApplicationController
  include ProfilePicture
  include CurrentProfile
  before_action :authenticate_account!
  before_action :check_status
  before_action :role

  def index
    @current_profile_picture = current_profile_picture
    @archives = Archive.where(profile_id: current_profile)
    @current_profile = Profile.find_by(id: current_profile)
  end

  def archive_post
    debugger
    archive_post_function
  end

  def un_archive_post
    debugger
    un_archive_post_function
  end

  private

  def archive_post_function
    post = Post.find_by(id: params[:id])
    new_post = Post.create
    archive_post = Archive.new(id: new_post.id)
    archive_post.caption = post.caption
    archive_post.location = post.location
    archive_post.comment_count = post.comment_count
    archive_post.likes_count = post.likes_count
    archive_post.profile_id = post.profile_id
    return unless archive_post.save

    archive_post.update(images: post.images_blobs)
    likes = Like.where(post_id: post.id)
    likes.update_all(post_id: archive_post.id)
    comments = Comment.where(post_id: post.id)
    comments.update_all(post_id: archive_post.id)
    post.destroy
    redirect_to profiles_path
  end

  def un_archive_post_function
    archive_post = Archive.find_by(id: params[:id])
    post = Post.find_by(id: archive_post.id)
    post.id = archive_post.id
    post.caption = archive_post.caption
    post.location = archive_post.location
    post.comment_count = archive_post.comment_count
    post.likes_count = archive_post.likes_count
    post.profile_id = archive_post.profile_id
    return unless post.save

    post.update(images: archive_post.images_blobs)
    archive_post.destroy
    redirect_to archives_path
  end
end
