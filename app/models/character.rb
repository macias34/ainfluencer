class Character < ApplicationRecord
  validates :name, presence: true
  validates :personality, presence: true
  has_many :tasks, dependent: :destroy
end
