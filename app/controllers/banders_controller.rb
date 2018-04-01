class BandersController < ApplicationController

    def index
        @banders = Bander.all
    end

    def new
    end

    def create 
        bander = Bander.new(bander_params)
        if bander.save
            session[:bander_id] = bander.id
            redirect_to bander_reports_path(bander)
        end
    end

    def show
        if params[:bander_id]
            @reports = Bander.find(params[:bander_id]).reports
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
