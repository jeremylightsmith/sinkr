module Loaders
  class Base
    def clear_events
      Event.delete_all ["source = ?", source]
      Photo.delete_all ["source = ?", source]
    end
  end
end