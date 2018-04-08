class BirdsOfSpecies < ApplicationRecord
    belongs_to :bander
    belongs_to :report
    belongs_to :species
    validates :number_banded, presence: true

    def species_attributes=(species_attributes)
        if new_species = Species.find_by(:name => species_attributes[:name], :code => species_attributes[:code])
            self.species = new_species
        end
    end

end
