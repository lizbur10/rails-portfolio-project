class Species < ApplicationRecord
    include ActiveModel::Validations
    has_many :birds_of_species, :class_name => "BirdsOfSpecies"
    has_many :banders, through: :birds_of_species
    has_many :reports, through: :birds_of_species

    validate :code_and_name_are_valid

    def code_and_name_are_valid
        errors.add(:code, "does not exist in the database") unless find_species_by_code
        errors.add(:name, "does not exist in the database") unless find_species_by_name
        if @species_by_code && @species_by_name
            errors.add(:name, "and alpha code do not match") unless @species_by_code == @species_by_name
        end
    end

    def find_species_by_code
        @species_by_code ||= Species.find_by(:code => code.upcase)
    end

    def find_species_by_name
        @species_by_name ||= Species.find_by(:name => name)
    end

end
