class BirdsOfSpeciesController < ApplicationController
    before_action :login_required
    before_action :get_report
    
    def new
    end

    def create
        @bos = BirdsOfSpecies.new
        if (@bos.update(birds_of_species_params) && params[:commit] == "Finished") || params[:commit] == "Finished"
            redirect_to bander_report_path(@bos.report.bander, @bos.report)
        elsif @bos.update(birds_of_species_params)
            redirect_to add_birds_path(@bos.report.bander, @bos.report)
        else
        #    render 'new'
        end
    end

    def index
        @birds_of_species = @report.birds_of_species
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

    def get_report
        @report = Report.find_by_date_slug(params[:id]) 
    end


end
