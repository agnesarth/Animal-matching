class Tag < ApplicationRecord
    has_many :tag_whos, dependent: :destroy
    has_many :pets, through: :tag_whos
end
