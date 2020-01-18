class Mark < ApplicationRecord

	belongs_to :company, counter_cache: :marks_count
    belongs_to :engineer
end
