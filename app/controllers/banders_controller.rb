class BandersController < ApplicationController
    before_action :login_required


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
        binding.pry
        if params[:id]
            @reports = Bander.find_by(:name => params[:id]).reports
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
