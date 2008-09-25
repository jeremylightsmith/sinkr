class Array
  def names
    map {|element| element.name }
  end
  
  def by_name(name)
    find {|element| element.name == name}
  end
end

class Object
  def explore_methods(sep = "<br>")
    (methods - 1.methods).sort.join(sep)
  end
end