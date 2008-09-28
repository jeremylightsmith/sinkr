module Merb
  module EventsHelper
    def month_name(month)
      Dated::MONTHS[month - 1]
    end
  end
end