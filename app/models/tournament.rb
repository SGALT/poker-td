class Tournament < ApplicationRecord
  has_many :rounds, dependent: :destroy
  belongs_to :user, dependent: :destroy
end
