# frozen_string_literal: true

class Archive < ApplicationRecord
  belongs_to :profile
  has_many_attached :images
end
