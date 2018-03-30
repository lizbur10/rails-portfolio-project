class SessionsController < ApplicationController

    def create
        @bander = Bander.find_by(:name => params[:name])
        return head(:forbidden) unless @bander.authenticate(params[:password])
        session[:bander_id] = @bander.id
    end

    def logged_in
        @reports = Report.all    # placeholder for scoped resource - draft vs. posted
    end
end