module ReportsHelper
    def format_report_datetime
        self.date.strftime('%B %d, %Y')
    end
end
