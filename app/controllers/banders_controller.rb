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
            redirect_to sessions_logged_in_path
        end
    end

    def show
    end

    def edit
    end

    private

    def bander_params
        params.require(:bander).permit(:name, :password, :password_confirmation)
    end
end
