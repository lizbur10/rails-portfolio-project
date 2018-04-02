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
        if birds_of_species_attributes[:"#{birds_of_species_attributes.length-1}"][:species_attributes][:name] != "" && !self.species.find_by(:name => birds_of_species_attributes[:"#{birds_of_species_attributes.length-1}"][:species_attributes][:name])
            self.birds_of_species.build(birds_of_species_attributes[:"#{birds_of_species_attributes.length-1}"])
        end
        self.save
        birds_of_species_attributes.each do |bosa|
            if bosa[1]["species_attributes"]["name"] != ""
                this_species_name = bosa[1]["species_attributes"]["name"]
                this_bird_of_species = self.species.find_by(:name => this_species_name).birds_of_species.first
                if bosa[1]["number_banded"].to_i != this_bird_of_species.number_banded
                    this_bird_of_species.number_banded = bosa[1]["number_banded"].to_i
                    this_bird_of_species.save
                end
            end
        end
    end

end
