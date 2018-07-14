class SpeciesController < ApplicationController
    before_action :login_required

    def find_by_code(code)
        species = Species.find_by(:code => code)
        render :json => species
    end

    def new
    end

    def show
    end

    def index
    end

    def edit
    end
end
