class BirdsOfSpeciesSerializer < ActiveModel::Serializer
  attributes :id, :number_banded
  belongs_to :report
  belongs_to :species
end
