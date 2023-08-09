# frozen_string_literal: true

class Friendship < ApplicationRecord
  # followed and follower keys are stored in the table
  belongs_to :followed, class_name: 'Profile'
  belongs_to :follower, class_name: 'Profile'

end
