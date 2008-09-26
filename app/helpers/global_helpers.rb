module Merb
  module GlobalHelpers
    def link_to_function(name, function, opts={})
      opts[:onclick] = "#{function}; return false;"
      opts[:href] = "#"
      %{<a #{ opts.to_xml_attributes }>#{name}</a>}
    end
  end
end
