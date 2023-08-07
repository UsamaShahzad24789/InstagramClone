class Profile < ApplicationRecord
    #profile has a default status of public
    enum status: {public_profile: 0, private_profile: 1}

    #each profile has many posts
    has_many :posts ,dependent: :destroy

    #Creating self association in a middle table of Friendship
    has_many :followed_profiles,foreign_key: :followed_id, class_name: "Friendship"
    has_many :followed,through: :followed_profiles,dependent: :destroy
    has_many :follower_profiles,foreign_key: :follower_id, class_name: "Friendship"
    has_many :follower,through: :follower_profiles,dependent: :destroy

    #scopes
    scope :account_has_profile, ->(a){where(account_id:a)}
    #scope :profile_exist,->(a){Profile.account_has_profile(current_account.id).exists?}

    #Using Active Storage to attach image and videos
    has_one_attached :profile_picture
end
