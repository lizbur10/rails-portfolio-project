class Bander < ApplicationRecord
    has_many :reports
    has_many :birds_of_species, :class_name => "BirdsOfSpecies"
    has_many :species, through: :birds_of_species
    has_secure_password
end
