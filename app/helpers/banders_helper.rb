module BandersHelper

    def current_bander
        @bander = Bander.find(session[:bander_id])
    end
end
