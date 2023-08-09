class Like < ApplicationRecord
  scope :increment_like,->(post){Post.find_by(id:post).increment!(:likes_count,1)}
end
