require 'yaml'

class Struct
  def to_yaml
    return self.to_h.to_yaml
  end
end
