class Bander < ApplicationRecord
    has_many :reports
    has_many :birds
    has_many :species, through: :birds    
end
