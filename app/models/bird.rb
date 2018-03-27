class Bird < ApplicationRecord
    belongs_to :bander
    belongs_to :report
    belongs_to :species
end
