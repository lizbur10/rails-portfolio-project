class ReportsController < ApplicationController
before_action :get_report, :login_required
skip_before_action :get_report, only: [:new, :create, :index, :posted_reports] #, :by_total_banded ]

    def index
        @reports = Report.all

        # render :layout => false
        render :json => @reports
    end

    def posted_reports
        @reports = Report.where(:status => "posted")

        render :json => @reports
    end

    def new
        @bander = Bander.find_by_slug(params[:bander_id])
        @report = @bander.reports.build
        session[:show_writeup_field] = false
        ##Automatically enters either the next date after the most recent report
        #or the current date
        if Report.all.length > 0 ## &CURRENT SEASON
            @report.date = Report.all.map{|r| r.date}.max + 1.day
        else
            @report.date = Time.now
        end
    end

    def create
        @report = Report.new(:bander_id => current_bander.id)
        if @report.update(report_params)
            session[:date] ||= @report.date
            # @banding_record =@report.birds_of_species.last
            # render "reports/edit", :layout => false
            redirect_to add_birds_path(@report.bander, @report)
            # render 'full_form'
        else
           render 'new'
        end
    end

    def edit
        @banding_records = @report.birds_of_species
        # @report.birds_of_species.build.build_species
    end

    def update
        session[:show_writeup_field] = true if params[:commit] == "Add a Writeup"
        session[:show_writeup_field] = false if params[:commit] == "Cancel"
        if @report && @report.update(report_params)
            # render "birds_of_species/show", :layout => false
            redirect_to bander_report_path(@report.bander)
        else
            render 'edit'
        end
    end

    def add_birds
        @bander = Bander.find_by_slug(params[:bander_id])
        @bos = @report.birds_of_species
        # @report.birds_of_species.build.build_species
    end

    def show
        @bos = @report.birds_of_species

        # render :layout => false
        # https://github.com/rails-api/active_model_serializers/blob/v0.10.6/docs/general/adapters.md#include-option
        respond_to do |format|
            # USING ACTIVE MODEL SERIALIZER TO CREATE THE JSON
            format.js {render json: @report, include: ['bander', 'birds_of_species', 'birds_of_species.species']} 
            format.html {render 'show.html'}
        end

    end

    def add_writeup
        session[:show_writeup_field] = true
        redirect_to bander_report_path(@report.bander, @report)
    end

    def post_report
        @report.update(:status => "posted")
        session[:show_writeup_field] = false

        redirect_to bander_path(@report.bander) 
    end

    # def by_total_banded
    #     @reports = Report.by_total_banded
    # end

    private

    def report_params
        params.require(:report).permit(
            :id,
            :date, 
            :bander_id,
            :content,
            :birds_of_species_attributes => [:bander_id, :report_id, :number_banded, :id,
                :species_attributes => [:code, :name, :id]]
            )
    end

    def get_report
        @report = Report.find_by_date_slug(params[:id]) 
    end

end
