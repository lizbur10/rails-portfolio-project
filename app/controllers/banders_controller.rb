class BandersController < ApplicationController

    def index
        @banders = Bander.all
    end

    def new
    end
    
    def show
    end

    def edit
    end

end
