class Favorite < ApplicationRecord

  belongs_to :info, counter_cache: :favorites_count
  belongs_to :user
end
