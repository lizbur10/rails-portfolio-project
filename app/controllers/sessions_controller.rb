class SessionsController < ApplicationController

    def new
        if !!session[:bander_id]
            redirect_to #logged in bander page
        else
            @bander = Bander.new
        end
    end

    def create
        @bander = Bander.find_by(:name => params[:name])
        return head(:forbidden) unless @bander.authenticate(params[:password])
        session[:bander_id] = @bander.id
    end

    def destroy
        session.delete :bander_id
        redirect_to login_path
    end


    ## THIS IS GOING TO MOVE
    def logged_in
        @reports = Report.all    # placeholder for scoped resource - draft vs. posted
    end
end