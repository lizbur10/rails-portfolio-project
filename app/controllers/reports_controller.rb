class ReportsController < ApplicationController
    def new
        @report = Report.new
        @report.species.build
        @report.birds_of_species.build
    end

    def create
        report = Report.new(report_params)
        session[:date] = report.date
        report.bander = Bander.find(session[:bander_id])
        report.birds_of_species.last.bander = report.bander
        report.birds_of_species.last.banding_date = report.date
        report.birds_of_species.last.number_banded = report_params[:species_attributes]["0"][:birds_of_species_attributes]["0"][:number_banded]
        binding.pry

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
            :species_attributes => [:code, :name, 
            :birds_of_species_attributes => [:number_banded]]
            )
    end

    def bird_params

    end 
end
