class Task < ApplicationRecord
  belongs_to :character
  has_many :results, dependent: :destroy
end
