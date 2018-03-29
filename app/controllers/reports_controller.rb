class ReportsController < ApplicationController
    def new
        @report = Report.new
        @report.species.build
        @report.birds_of_species.build
    end

    def create

        report = Report.new(report_params)
        binding.pry

        # report.bander = current_bander
        report.bander_id = 1 ## hard coded for now
        report.birds_of_species.last.bander = report.bander
        report.birds_of_species.last.banding_date = report.date

        report.save
        redirect_to edit_report_path(report)
    end
    
    def show
    end

    def index
    end

    def edit
        @report = Report.find(params[:id])
        @report.species.build
        @report.birds_of_species.build
    end

    def update
    end

    def preview
    end

    def report_params
        params.require(:report).permit(
            :date, 
            :species_attributes => [:code, :name], 
            :birds_of_species_attributes => [:number_banded]
            )
    end

    def bird_params

    end 
end
