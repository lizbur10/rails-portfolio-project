class SessionsController < ApplicationController
    def logged_in
        @bander = Bander.find(1) # placeholder for login functionality
        @reports = Report.all    # placeholder for scoped resource - draft vs. posted
    end
end