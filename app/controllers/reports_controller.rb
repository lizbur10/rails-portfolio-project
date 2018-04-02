class ReportsController < ApplicationController
before_action :get_report, :login_required
skip_before_action :get_report, only: [:new, :create, :index, :add_writeup]

    def new
        @report = Report.new
        @report.birds_of_species.build.build_species
    end

    def create
        report = Report.create
        report.update(report_params)
        session[:date] = report.date
        #if report.save
        report.save
            redirect_to edit_report_path(report)
        # else/end
    end
    
    def edit
        # @report = Report.find(params[:id])
        @report.birds_of_species.build.build_species
    end

    def update
        # report = Report.find(params[:id])
        @report.update(report_params)

        redirect_to edit_report_path(report)
    end

    def show
        # @report = Report.find(params[:id])
    end

    def index
        @reports = Report.all
        # split this out by draft vs. posted
        # only show drafts for current_bander
    end

    def add_writeup
        session[:show_writeup] = true
    end


    def preview
        # @report = Report.find(params[:id])
    end

    private

    def report_params
        params.require(:report).permit(
            :id,
            :date, 
            :bander_id, 
            :birds_of_species_attributes => [:bander_id, :number_banded,
                :species_attributes => [:code, :name]]
            )
    end

    def get_report
        @report = Report.find(params[:id])
    end

end
