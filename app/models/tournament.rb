class Tournament < ApplicationRecord
  has_many :rounds, dependent: :destroy
  belongs_to :user

  amoeba do
    enable
    include_association :rounds
  end
end
