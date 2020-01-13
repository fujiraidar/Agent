class Follow < ApplicationRecord
  belongs_to :engineer, counter_cache: :follows_count
  belongs_to :user
end
