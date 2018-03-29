class Species < ApplicationRecord
    has_many :birds_of_species, :class_name => "BirdsOfSpecies"
    has_many :banders, through: :birds_of_species
    has_many :reports, through: :birds_of_species
end
