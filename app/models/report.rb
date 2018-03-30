class Report < ApplicationRecord
    belongs_to :bander
    has_many :birds_of_species, :class_name => "BirdsOfSpecies"
    has_many :species, through: :birds_of_species
    accepts_nested_attributes_for :species

    def format_report_datetime
        self.date.strftime('%B %d, %Y')
        # Time.parse(self.appointment_datetime).strftime('%B %d, %Y at %H:%M')
    end

    def species_attributes=(species_attributes)
        binding.pry
        species_attributes.values.each do |species_attribute|
            new_species = Species.find_or_create_by(:name => species_attribute[:name])
            self.species << new_species
        end
    end
end
