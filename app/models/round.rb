class Round < ApplicationRecord
  belongs_to :tournament

  enum state: { pending: 0, running: 1, paused: 2, ended: 3, actived: 4 }
end
