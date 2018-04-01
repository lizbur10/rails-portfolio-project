class Report < ApplicationRecord
    belongs_to :bander
    has_many :birds_of_species, :class_name => "BirdsOfSpecies"
    has_many :species, through: :birds_of_species
    #accepts_nested_attributes_for :birds_of_species

    def format_report_datetime
        self.date.strftime('%B %d, %Y')
        # Time.parse(self.appointment_datetime).strftime('%B %d, %Y at %H:%M')
    end

    def birds_of_species_attributes=(birds_of_species_attributes)
        if !self.species.find_by(:name => birds_of_species_attributes[:"#{birds_of_species_attributes.length-1}"][:species_attributes][:name])
            self.birds_of_species.build(birds_of_species_attributes[:"#{birds_of_species_attributes.length-1}"])
            self.save
        end
    end

end
