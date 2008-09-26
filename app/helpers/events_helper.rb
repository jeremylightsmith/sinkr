module Merb
  module EventsHelper
    def display_month(month)
      Dated::MONTHS[month - 1]
    end
  end
end