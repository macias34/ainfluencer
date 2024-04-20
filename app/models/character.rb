class Character < ApplicationRecord
  validates :name, presence: true
  validates :personality, presence: true
  validates :image_src, presence: true

  has_many :tasks, dependent: :destroy
end
