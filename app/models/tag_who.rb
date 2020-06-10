class TagWho < ApplicationRecord
  belongs_to :tag
  belongs_to :pet
end
