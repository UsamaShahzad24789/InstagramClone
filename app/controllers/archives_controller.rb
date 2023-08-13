class ArchivesController < ApplicationController
  
  include ProfilePicture
  include CurrentProfile
  before_action :authenticate_account!

  def index
    @current_profile_picture = current_profile_picture
    @archives=Archive.where(profile_id:current_profile)
    @current_profile=Profile.find_by(id:current_profile)
  end

  def archive_post
      # debugger
      post=Post.find_by(id:params[:id])
      archive_post=Archive.new
      archive_post.caption=post.caption
      archive_post.location=post.location
      archive_post.comment_count=post.comment_count
      archive_post.likes_count=post.likes_count
      archive_post.profile_id=post.profile_id
      if archive_post.save
        archive_post.update(image:post.image_blob)
        Post.create(id:archive_post.id)
        likes=Like.where(post_id:post.id)
        likes.update_all(post_id: archive_post.id)
        comments=Comment.where(post_id:post.id)
        comments.update_all(post_id: archive_post.id)
        post.destroy
        redirect_to profiles_path
      end
  end

  def unArchive_post
      # debugger
      archive_post=Archive.find_by(id:params[:id])
      post=Post.find_by(id:archive_post.id)
      post.id=archive_post.id
      post.caption=archive_post.caption
      post.location=archive_post.location
      post.comment_count=archive_post.comment_count
      post.likes_count=archive_post.likes_count
      post.profile_id=archive_post.profile_id
      if post.save
        post.update(image:archive_post.image_blob)
        archive_post.destroy
        redirect_to archives_path
      end
  end

  # private
  #   def archive_post_copy
      
  #   end
end
