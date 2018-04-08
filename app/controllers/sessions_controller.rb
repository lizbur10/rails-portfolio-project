class SessionsController < ApplicationController

    def new
        @bander = Bander.new
        if !!@current_bander
            redirect_to bander_path(Bander.find_by_slug(session[:bander_id]))
        end
    end

    def create
        if request.env["omniauth.auth"]
            if @bander = Bander.find_by(:name => request.env["omniauth.auth"]["info"]["first_name"])
                session[:bander_id] = @bander.to_param

                redirect_to bander_path(@bander)                 
            else
                # Account not found message
                @bander = Bander.new
                @bander.valid?
                render 'new'
            end
        else
            if @bander = Bander.find_by(:name => params[:name])
                if @bander.authenticate(params[:password])
                    session[:bander_id] = @bander.to_param

                    redirect_to bander_path(@bander) 
                else
                    @bander.errors.add(:password, ": incorrect password")
                    render 'new'
                end
            else
                @bander = Bander.new(:name => params[:name], :password => params[:password])
                @bander.valid?
                render 'new'
            end
        end
    end

    def destroy
        session.delete :bander_id
        
        redirect_to root_path
    end

end