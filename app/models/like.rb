class Like < ApplicationRecord
    belongs_to :liker, class_name: "Pet"
    belongs_to :liked, class_name: "Pet"
    validates :liked, uniqueness: { scope: [:liker]}
end
