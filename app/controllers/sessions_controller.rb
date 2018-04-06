class SessionsController < ApplicationController

    def new
        @bander = Bander.new
        if !!session[:bander_id]
            redirect_to bander_path(Bander.find(session[:bander_id]))
        end
    end

    def create
        if request.env["omniauth.auth"] # Google sign in
            if @bander = Bander.find_by(:name => request.env["omniauth.auth"]["info"]["first_name"])
                session[:bander_id] = @bander.id

                redirect_to bander_path(@bander)                 
            else
                # Account not found message
                redirect_to login_path
            end
        else
            @bander = Bander.find_by(:name => params[:name]) # regular sign in
            if @bander && @bander.authenticate(params[:password])
                session[:bander_id] = @bander.id

                redirect_to bander_path(@bander) 
            end
        end
    end

    def destroy
        session.delete :bander_id
        
        redirect_to root_path
    end

end