class Species < ApplicationRecord
    include ActiveModel::Validations
    has_many :birds_of_species, :class_name => "BirdsOfSpecies"
    has_many :banders, through: :birds_of_species
    has_many :reports, through: :birds_of_species

    validate :code_and_name_are_valid

    def code_and_name_are_valid
        if Species.find_by(:code => code.upcase)
            if Species.find_by(:name => name)
                if Species.find_by(:code => code.upcase) != Species.find_by(:name => name)
                    errors.add(:name, "and alpha code do not match")
                end
            else
                errors.add(:name, "does not exist in the database")
            end
        else
            errors.add(:code, "does not exist in the database") 
        end
        binding.pry
    end
end
