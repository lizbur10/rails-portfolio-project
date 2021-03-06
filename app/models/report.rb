class Report < ApplicationRecord
    belongs_to :bander
    has_many :birds_of_species, :class_name => "BirdsOfSpecies"
    has_many :species, through: :birds_of_species
    
    validates :date, uniqueness: true
    validate :new_species_is_valid
    validate :new_bird_of_species_is_valid

    scope :draft, -> {where(status: 'draft')}
    scope :posted, -> {where(status: 'posted')}

    # def self.by_total_banded
    #     self.joins(:birds_of_species).order("SUM(number_banded) desc").group("report_id")
    # end

    # def total_banded
    #     sum = 0
    #     self.birds_of_species.each do |b|
    #         sum += b.number_banded
    #     end
    #     sum
    # end

    def to_param
        slugify_date(date) if self.date
    end

    def slugify_date(date)
        date.strftime('%b%d')
    end

    def self.find_by_date_slug(date_slug)
        self.where(:date => DateTime.strptime(date_slug, '%b%d')).first
    end


    def birds_of_species_attributes=(birds_of_species_attributes)
        get_new_bird_info(birds_of_species_attributes)
        if all_fields_blank?
            self.errors.clear
            return
        else
            @new_species = Species.new(@new_species_info)
            if !self.species.find_by(:name => @new_species_name)
                @new_bird_of_species = self.birds_of_species.build(@new_birds_of_species_info)
            end
            self.valid?
            birds_of_species_attributes.each do |bosa|
                if bosa[1]["species_attributes"]["name"] != ""
                    this_species_name = bosa[1]["species_attributes"]["name"]
                    if found_species = self.species.find_by(:name => this_species_name)
                        @this_bird_of_species = self.birds_of_species.find_by(:species_id => found_species.id)
                        if bosa[1]["number_banded"].to_i != @this_bird_of_species.number_banded
                            @this_bird_of_species.number_banded = bosa[1]["number_banded"].to_i
                            @this_bird_of_species.save
                        end
                    end
                end
            end
        end
    end

    def new_species_is_valid
        if @new_species && !@new_species.valid?
            errors.add(:species, ": name #{@new_species.errors[:name].last}") if @new_species.errors[:name].last
            errors.add(:species, ": alpha code #{@new_species.errors[:code].last}") if @new_species.errors[:code].last
        end
    end

    def new_bird_of_species_is_valid
        if @new_bird_of_species && !@new_bird_of_species.valid?
            errors.add(:species, ": number banded #{@new_bird_of_species.errors[:number_banded].first}") if @new_bird_of_species.errors[:number_banded].first
            errors[:birds_of_species].clear
        end
    end

    def get_new_bird_info(birds_of_species_attributes)
        @new_birds_of_species_info = birds_of_species_attributes[:"#{birds_of_species_attributes.length-1}"]
        @new_species_info = @new_birds_of_species_info[:species_attributes]
        @new_species_name = @new_species_info[:name]
    end

    def all_fields_blank?
        @new_birds_of_species_info[:number_banded] == "" && @new_birds_of_species_info[:species_attributes][:code] == "" && @new_birds_of_species_info[:species_attributes][:name] == ""
    end

end
