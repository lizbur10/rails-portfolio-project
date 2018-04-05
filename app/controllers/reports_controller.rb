class ReportsController < ApplicationController
before_action :get_report, :login_required
skip_before_action :get_report, only: [:new, :create, :index]

    def new
        bander = Bander.find_by_slug(params[:bander_id])
        @report = bander.reports.build
        @report.birds_of_species.build.build_species
        session[:show_writeup_field] = false
    end

    def create
        report = Report.create
        report.update(report_params)
        session[:date] = report.date
        #if report.save
        report.save
            redirect_to edit_bander_report_path(report.bander, report)
        # else/end
    end
    
    def edit
        @report.birds_of_species.build.build_species
    end

    def update
        @report.update(report_params)
        if params[:commit] == "Add a Writeup"
            session[:show_writeup_field] = true
        elsif
            params[:commit] == "Save writeup"
        end
        redirect_to edit_bander_report_path(@report.bander, @report)
    end

    def show
    end

    def index
        @reports = Report.all
        # split this out by draft vs. posted
        # only show drafts for current_bander
    end

    def preview
    end

    def post_report
        @report.update(:status => "posted")
        session[:show_writeup_field] = false

        redirect_to bander_path(@report.bander) 
    end

    private

    def report_params
        params.require(:report).permit(
            :id,
            :date, 
            :bander_id,
            :content,
            :birds_of_species_attributes => [:bander_id, :number_banded,
                :species_attributes => [:code, :name]]
            )
    end

    def get_report
        @report = Report.find_by_date_slug(params[:id]) 
    end

end
