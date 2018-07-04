class ReportSerializer < ActiveModel::Serializer
  attributes :id, :date, :content
  belongs_to :bander
  has_many :birds_of_species
  has_many :species, through: :birds_of_species
end
