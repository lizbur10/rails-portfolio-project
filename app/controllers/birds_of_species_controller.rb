class BirdsOfSpeciesController < ApplicationController
    before_action :login_required
    
    def new
    end

    def create
        @bos = BirdsOfSpecies.new
        if @bos.update(birds_of_species_params)
            redirect_to add_birds_path(@bos.report.bander, @bos.report)

            # render 'birds_of_species/show'
        else
        #    render 'new'
        end
    end

    private
    def birds_of_species_params
        params.require(:birds_of_species).permit(
            :id,
            :report_id, 
            :bander_id,
            :number_banded,
            :species_attributes => [:code, :name, :id]
            )
    end


end
