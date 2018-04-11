module ReportsHelper

    def report_datetime_formatted(date)
        date.strftime('%B %d')
    end

    def code_error_exists(report)
        !report.errors[:species].empty? && report.errors[:species].any? { | str | str.include?("code") }
    end

    def name_error_exists(report)
        !report.errors[:species].empty? && report.errors[:species].any? { | str | str.include?("name") }
    end

    def last_record?(bird_of_species, report)
        bird_of_species.object == report.birds_of_species.last
    end
end
