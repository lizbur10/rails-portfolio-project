class Bander < ApplicationRecord
    has_many :reports
    has_many :birds_of_species #, :class_name => "BirdsOfSpecies"
    has_many :species, through: :birds_of_species
    has_secure_password
    validates :name, presence: true
    validates :password, presence: true

    def to_param
        self.name
    end

    def self.find_by_slug(slug)
        self.where(name: slug).first
    end
end
