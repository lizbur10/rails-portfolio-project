module ReportsHelper
    # def report_datetime_formatted
    #     Time.parse(session[:date]).strftime('%B %d, %Y')
    # end

    def report_datetime_formatted(date)
        date.strftime('%B %d')
    end
end
