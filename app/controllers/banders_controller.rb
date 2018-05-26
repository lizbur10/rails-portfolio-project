class BandersController < ApplicationController
    before_action :login_required
    skip_before_action :login_required, only: [:new, :create, :index]


    def index
        @banders = Bander.all
    end

    def new
        @bander = Bander.new
    end

    def create 
        @bander = Bander.new(bander_params)
        if @bander.save
            session[:bander_id] = @bander.to_param
            redirect_to bander_path(@bander)
        else

            render new_bander_path
            # output bander.errors.messages to login page
        end
    end

    def show
        if !!current_bander
            @draft_reports = @current_bander.reports.draft
            @posted_reports = @current_bander.reports.posted
        else
            redirect_to login_path
        end

    end

    def edit
    end

    private

    def bander_params
        params.require(:bander).permit(:name, :password, :password_confirmation)
    end
end
