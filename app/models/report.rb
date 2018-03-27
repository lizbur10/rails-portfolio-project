class Report < ApplicationRecord
    belongs_to :bander
    has_many :birds
    has_many :species, through: :birds

    def format_report_datetime
        self.date.strftime('%B %d, %Y')
        # Time.parse(self.appointment_datetime).strftime('%B %d, %Y at %H:%M')
    end

end
