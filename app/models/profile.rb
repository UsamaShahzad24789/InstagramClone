class Profile < ApplicationRecord
    enum status: {public: 0, private: 1}
    has_many :posts ,dependent: :destroy
    # has_one_attached :image
    # has_one_attached :video
    # has_many_attached :images
end
