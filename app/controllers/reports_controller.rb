class ReportsController < ApplicationController
before_action :get_report, :login_required
skip_before_action :get_report, only: [:new, :create, :index, :by_total_banded]

    def index
        @reports = Report.all
    end

    def new
        @bander = Bander.find_by_slug(params[:bander_id])
        @report = @bander.reports.build
        @report.birds_of_species.build.build_species
        session[:show_writeup_field] = false
    end

    def create
        @report = Report.new(:bander_id => current_bander.id)
        if @report.update(report_params)
            session[:date] = @report.date
            @banding_record =@report.birds_of_species.last
            render "birds_of_species/show", :layout => false
            # redirect_to edit_bander_report_path(@report.bander, @report)
        else
           render 'new'
        end
    end
    
    def edit
        @report.birds_of_species.build.build_species
    end

    # def update
    #     session[:show_writeup_field] = true if params[:commit] == "Add a Writeup"
    #     if @report && @report.update(report_params)
    #         redirect_to edit_bander_report_path(@report.bander, @report)
    #     else
    #         render 'edit'
    #     end
    # end

    def show
    end

    def preview
    end

    def post_report
        @report.update(:status => "posted")
        session[:show_writeup_field] = false

        redirect_to bander_path(@report.bander) 
    end

    def by_total_banded
        @reports = Report.by_total_banded
    end

    private

    def report_params
        params.require(:report).permit(
            :id,
            :date, 
            :bander_id,
            :content,
            :birds_of_species_attributes => [:bander_id, :number_banded, :id,
                :species_attributes => [:code, :name, :id]]
            )
    end

    def get_report
        @report = Report.find_by_date_slug(params[:id]) 
    end

end
