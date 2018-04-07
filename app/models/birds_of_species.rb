class BirdsOfSpecies < ApplicationRecord
    belongs_to :bander
    belongs_to :report
    belongs_to :species
    validates :number_banded, presence: true

    def species_attributes=(species_attributes)
        new_species = Species.find_or_create_by(:name => species_attributes[:name])
        self.species = new_species
    end

end
