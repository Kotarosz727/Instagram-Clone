class Like < ApplicationRecord
  belongs_to :micropost, counter_cache: :likes_count
  belongs_to :user
end