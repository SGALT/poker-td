class Tournament < ApplicationRecord
  has_many :rounds, dependent: :destroy
end
