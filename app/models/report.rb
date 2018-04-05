class Report < ApplicationRecord
    belongs_to :bander
    has_many :birds_of_species, :class_name => "BirdsOfSpecies"
    has_many :species, through: :birds_of_species

    scope :draft, -> {where(status: 'draft')}
    scope :posted, -> {where(status: 'posted')}

    def self.by_total_banded
        self.joins(:birds_of_species).order("SUM(number_banded) desc").group("report_id")
    end

    def self.find_by_date_slug(date_slug)
        self.where(:date => DateTime.strptime(date_slug, '%b%d')).first
    end

    def total_banded
        sum = 0
        self.birds_of_species.each do |b|
            sum += b.number_banded
        end
        sum
    end

    def to_param
        slugify_date(date) if self.date
    end

    def slugify_date(date)
        date.strftime('%b%d')
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
