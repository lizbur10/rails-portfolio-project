module ReportsHelper
    # def report_datetime_formatted
    #     Time.parse(session[:date]).strftime('%B %d, %Y')
    # end

    def report_datetime_formatted(date)
        date.strftime('%B %d')
    end

    def code_error_exists(report)
        report.errors[:species].last && report.errors[:species].last.include?("code")
    end

    def name_error_exists(report)
        report.errors[:species].first && report.errors[:species].first.include?("name")
    end

    def last_record?(bird_of_species, report)
        bird_of_species.object == report.birds_of_species.last
    end
end
