class BirdsOfSpeciesController < ApplicationController
    before_action :login_required
    
    def new
    end

    def create
        @bos = BirdsOfSpecies.new
        if @bos.update(bos_params)
            binding.pry
        else
        #    render 'new'
        end
    end

end
