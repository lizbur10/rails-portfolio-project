class Species < ApplicationRecord
    has_many :birds
    has_many :banders, through: :birds
    has_many :reports, through: :birds
end
