class BandersController < ApplicationController

    def index
        @banders = Bander.all
    end

    def new
        def create 
            bander = Bander.create(bander_params)
        end
    end
    
    def show
    end

    def edit
    end

end
