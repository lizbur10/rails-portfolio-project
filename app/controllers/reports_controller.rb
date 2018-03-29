class ReportsController < ApplicationController
    def new
        @report = Report.new
        @report.species.build
    end

    def create

        report = Report.new(report_params)

        # report.bander = current_bander
        report.bander_id = 1 ## hard coded for now
        number_banded = params[:number_banded].to_i
        (number_banded-1).times do 
            report.birds.build(:species => report.species.last)
        end
        report.birds.each do |bird|
            bird.bander = report.bander
            bird.banding_date = report.date
        end

        binding.pry
        report.save
        redirect_to edit_report_path(report)
    end
    
    def show
    end

    def index
    end

    def edit
        @report = Report.find(params[:id])
    end

    def update
    end

    def preview
    end

    def report_params
        params.require(:report).permit(:date, :species_attributes => [:code, :name])
    end

    def bird_params

    end 
end
