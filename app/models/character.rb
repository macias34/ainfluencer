class Character < ApplicationRecord
  validates :name, presence: true
  validates :personality, presence: true

end
