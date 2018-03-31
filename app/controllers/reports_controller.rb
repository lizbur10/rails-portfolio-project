class ReportsController < ApplicationController
    def new
        @report = Report.new
        @report.birds_of_species.build.build_species
    end

    def create
        report = Report.new(report_params)
        binding.pry
        session[:date] = report.date
        report.save
        redirect_to edit_report_path(report)
    end
    
    def edit
        @report = Report.find(params[:id])
        @report.species.build
        @report.birds_of_species.build
    end

    def show
    end

    def index
        if params[:bander_id]
            @reports = Bander.find(params[:bander_id]).reports
        else
            @reports = Report.all
        end
    end


    def update
        report = Report.find(params[:id])
        binding.pry
        report.update(report_params)

        redirect_to edit_report_path(report)
    end

    # def preview
    # end

    private

    def report_params
        params.require(:report).permit(
            :date, 
            :bander_id, 
            :birds_of_species_attributes => [:bander_id, :number_banded,
                :species_attributes => [:code, :name]]
            )
    end

end
