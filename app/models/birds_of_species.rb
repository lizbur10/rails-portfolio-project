class BirdsOfSpecies < ApplicationRecord
    belongs_to :bander
    belongs_to :report
    belongs_to :species
    validates :number_banded, presence: true

    def species_attributes=(species_attributes)
        if found_species = Species.find_by(:name => species_attributes[:name], :code => species_attributes[:code].upcase)
            self.species = found_species
        else
            self.species = Species.new(:name => species_attributes[:name], :code => species_attributes[:code].upcase)
        end
    end
    

end
