class ReportsController < ApplicationController
    def new
        @report = Report.new
        @report.species.build
        @report.species.build

    end
    
    def show
    end

    def index
    end

    def edit
    end

    def preview
    end
end
