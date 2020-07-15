class Poeet < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: {in: 1..140}
end