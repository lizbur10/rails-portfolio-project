class Bird < ApplicationRecord
    belongs_to :bander
    belongs_to :report
    belongs_to :species

    ## custom writer for bird? 
    #  assign date, bander_id, report_id, species_id
end
